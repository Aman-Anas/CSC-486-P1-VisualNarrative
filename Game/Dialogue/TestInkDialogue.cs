using System;
using System.Linq;
using System.Threading.Tasks;
using Godot;
using GodotInk;
using GodotTask;

namespace Game.Dialogue;

public partial class TestInkDialogue : VBoxContainer
{
    [Export]
    private InkStory story;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        UpdateStory();
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta) { }

    private async void UpdateStory()
    {
        // Clear the existing text and content.
        foreach (Node child in GetChildren())
            child.QueueFree();

        // How long to take to reveal each line (in ms)
        const int RevealLineDelay = 500;

        // Reveal each line of the story piece-by-piece
        while (story.CanContinue)
        {
            var nextText = story.Continue();

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

            Label content = new() { Text = nextText.TrimEnd('\n') };
            AddChild(content);

            // Create a tween animation to fade in the text
            var testFade = GetTree().CreateTween();
            testFade.TweenMethod(
                Callable.From((Color tweened) => content.Modulate = tweened),
                new Color(1, 1, 1, 0.0f),
                new Color(1.0f, 1.0f, 1.0f, 1.0f),
                RevealLineDelay / 1000.0f
            );

            await GDTask.Delay(RevealLineDelay);
        }

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
            AddChild(button);

            var fadeButton = GetTree().CreateTween();
            fadeButton.TweenMethod(
                Callable.From((Color tweened) => button.Modulate = tweened),
                new Color(0, 0, 0, 0.0f),
                new Color(1.0f, 1.0f, 1.0f, 1.0f),
                RevealLineDelay / 1000.0f
            );

            // Delay between revealing each choice
            await GDTask.Delay(RevealLineDelay);
        }
    }
}
