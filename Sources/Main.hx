package;

import kha.Image;
import kha.Assets;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

import kha.Shaders;
import kha.graphics4.BlendingFactor;
import kha.graphics4.FragmentShader;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexData;
import kha.graphics4.VertexShader;
import kha.graphics4.VertexStructure;
import kha.graphics4.TextureUnit;

class Main {
	static var pipeline:PipelineState;
	static var maskId:TextureUnit;

	static function update(): Void {

	}

	static function render(framebuffer: Framebuffer): Void {
        framebuffer.g4.begin();
        framebuffer.g4.setTexture(maskId, Assets.images.cat_mask);
        framebuffer.g4.end();

		framebuffer.g2.begin();
		framebuffer.g2.pipeline = pipeline;
		framebuffer.g2.drawImage(Assets.images.cat1, 0, 0);
		framebuffer.g2.end();
	}

	public static function main() {
		System.start({title: "Kha", width: 800, height: 600}, function (_) {

			final structure = new VertexStructure();
			structure.add('vertexPosition', VertexData.Float32_3X);
			structure.add('vertexUV', VertexData.Float32_2X);
			structure.add('vertexColor', VertexData.UInt8_4X_Normalized);
			pipeline = new PipelineState();
			pipeline.inputLayout = [structure];
			pipeline.vertexShader = Shaders.test_vert;
			pipeline.fragmentShader = Shaders.test_frag;
			pipeline.blendSource = BlendingFactor.BlendOne;
			pipeline.blendDestination = BlendingFactor.InverseSourceAlpha;
			pipeline.alphaBlendSource = BlendingFactor.BlendOne;
			pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
			pipeline.compile();

			maskId = pipeline.getTextureUnit('mask');

			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (framebuffers) { render(framebuffers[0]); });
			});
		});
	}
}
