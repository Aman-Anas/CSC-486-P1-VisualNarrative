using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Godot;
using GodotInk;
using GodotTask;

namespace Game.Dialogue;

public partial class TestInkDialogue : VBoxContainer
{
    [Export]
    private InkStory story = null!;

    [Export]
    private Button fastForward = null!;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        UpdateStory();

        fastForward.Pressed += () =>
        {
            foreach (var tween in currentTweens)
            {
                tween.CustomStep(9999999);
            }
            foreach (var token in cancellationTokens)
            {
                token.Cancel();
            }
        };
    }

    readonly List<Tween> currentTweens = [];
    readonly List<Button> currentButtons = [];
    readonly List<CancellationTokenSource> cancellationTokens = [];

    private async void UpdateStory()
    {
        foreach (var tween in currentTweens)
        {
            tween.Kill();
        }
        currentTweens.Clear();
        currentButtons.Clear();
        cancellationTokens.Clear();

        // Clear the existing text and content.
        foreach (Node child in GetChildren())
            child.QueueFree();

        const int LineRevealTime = 500;

        // How long to take to reveal each char (in ms)
        const int CharRevealTime = 20; // ms

        // Reveal each line of the story piece-by-piece
        while (story.CanContinue)
        {
            var nextText = story.Continue().TrimEnd('\n');

            if (story.CurrentTags.Contains("RESTART"))
            {
                story.ResetState();
                UpdateStory();
                return;
            }

            if (story.CurrentTags.Contains("EMPTY_LINE"))
            {
                Label empty = new();
                AddChild(empty);
            }

            Label content =
                new() { Text = nextText, AutowrapMode = TextServer.AutowrapMode.WordSmart };
            AddChild(content);
            content.AddThemeFontSizeOverride("font_size", 20);

            // Create a tween animation to fade in the text
            var testFade = GetTree().CreateTween();
            testFade.TweenMethod(
                Callable.From((Color tweened) => content.Modulate = tweened),
                new Color(1, 1, 1, 0.0f),
                new Color(1.0f, 1.0f, 1.0f, 1.0f),
                LineRevealTime / 1000.0f
            );

            // Typewriter time
            var typewriteTime = CharRevealTime * nextText.Length;
            testFade
                .Parallel()
                .TweenMethod(
                    Callable.From((float amt) => content.VisibleRatio = amt),
                    0f,
                    1f,
                    typewriteTime / 1000f
                );

            currentTweens.Add(testFade);

            CancellationTokenSource tokenSource = new();
            cancellationTokens.Add(tokenSource);
            try
            {
                await GDTask.Delay(
                    Math.Max(LineRevealTime, typewriteTime),
                    cancellationToken: tokenSource.Token
                );
            }
            catch (OperationCanceledException) { }
        }
        Label spacer = new Label();
        AddChild(spacer);

        // Delay between revealing all text and displaying the options
        await GDTask.Delay(50); // ms

        // Add buttons for each choice
        foreach (InkChoice choice in story.CurrentChoices)
        {
            Button button = new() { Text = choice.Text };

            button.Pressed += () =>
            {
                story.ChooseChoiceIndex(choice.Index);
                UpdateStory();
            };
            button.Disabled = true;

            button.AddThemeFontSizeOverride("font_size", 20);

            AddChild(button);
            currentButtons.Add(button);

            var fadeButton = GetTree().CreateTween();
            fadeButton.TweenMethod(
                Callable.From((Color tweened) => button.Modulate = tweened),
                new Color(0, 0, 0, 0.0f),
                new Color(1.0f, 1.0f, 1.0f, 1.0f),
                LineRevealTime / 1000.0f
            );
            currentTweens.Add(fadeButton);
        }

        foreach (var button in currentButtons)
        {
            button.Disabled = false;
        }
    }
}
