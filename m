Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B55B19D
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2019 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfF3Urq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jun 2019 16:47:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48718 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfF3Urq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jun 2019 16:47:46 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 47CFD255;
        Sun, 30 Jun 2019 22:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1561927663;
        bh=dBe3yAq6Q1C4VcXG06Vz7nXaIG0pbndeYddXgCeKg/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvQhk0CYuLPmvsnXgMfQ54qleQCRDC8h/euYya5WJKEGZT4y8cPE6Qkd/pT7ktb2c
         BNXwwxE1Vl5Rh76y5JDDSQFISCh4/fpR2a+4HdNPKJdBK14JEHP2ycWds3maKAy/UD
         Ef8mWClZdv+sgFXvRnCu62dq9xZKjV4vxoaEy31k=
Date:   Sun, 30 Jun 2019 23:47:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/4] drm+dt+efi: support devices with multiple possible
 panels
Message-ID: <20190630204723.GH7043@pendragon.ideasonboard.com>
References: <20190630203614.5290-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190630203614.5290-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Sun, Jun 30, 2019 at 01:36:04PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Now that we can deal gracefully with bootloader (firmware) initialized
> display on aarch64 laptops[1], the next step is to deal with the fact
> that the same model of laptop can have one of multiple different panels.
> (For the yoga c630 that I have, I know of at least two possible panels,
> there might be a third.)

I have to ask the obvious question: why doesn't the boot loader just
pass a correct DT to Linux ? There's no point in passing a list of
panels that are not there, this seems quite a big hack to me. A proper
boot loader should construct the DT based on hardware detection.

> This is actually a scenario that comes up frequently in phones and
> tablets as well, so it is useful to have an upstream solution for this.
> 
> The basic idea is to add a 'panel-id' property in dt chosen node, and
> use that to pick the endpoint we look at when loading the panel driver,
> e.g.
> 
> / {
> 	chosen {
> 		panel-id = <0xc4>;
> 	};
> 
> 	ivo_panel {
> 		compatible = "ivo,m133nwf4-r0";
> 		power-supply = <&vlcm_3v3>;
> 		no-hpd;
> 
> 		ports {
> 			port {
> 				ivo_panel_in_edp: endpoint {
> 					remote-endpoint = <&sn65dsi86_out_ivo>;
> 				};
> 			};
> 		};
> 	};
> 
> 	boe_panel {
> 		compatible = "boe,nv133fhm-n61";
> 		power-supply = <&vlcm_3v3>;
> 		no-hpd;
> 
> 		ports {
> 			port {
> 				boe_panel_in_edp: endpoint {
> 					remote-endpoint = <&sn65dsi86_out_boe>;
> 				};
> 			};
> 		};
> 	};
> 
> 	sn65dsi86: bridge@2c {
> 		compatible = "ti,sn65dsi86";
> 
> 		...
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			...
> 
> 			port@1 {
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 				reg = <1>;
> 
> 				endpoint@c4 {
> 					reg = <0xc4>;
> 					remote-endpoint = <&boe_panel_in_edp>;
> 				};
> 
> 				endpoint@c5 {
> 					reg = <0xc5>;
> 					remote-endpoint = <&ivo_panel_in_edp>;
> 				};
> 			};
> 		};
> 	}
> };
> 
> Note that the panel-id is potentially a sparse-int.  The values I've
> seen so far on aarch64 laptops are:
> 
>   * 0xc2
>   * 0xc3
>   * 0xc4
>   * 0xc5
>   * 0x8011
>   * 0x8012
>   * 0x8055
>   * 0x8056
> 
> At least on snapdragon aarch64 laptops, they can be any u32 value.
> 
> However, on these laptops, the bootloader/firmware is not populating the
> chosen node, but instead providing an "UEFIDisplayInfo" variable, which
> contains the panel id.  Unfortunately EFI variables are only available
> before ExitBootServices, so the second patch checks for this variable
> before EBS and populates the /chosen/panel-id variable.
> 
> [1] https://patchwork.freedesktop.org/series/63001/
> 
> Rob Clark (4):
>   dt-bindings: chosen: document panel-id binding
>   efi/libstub: detect panel-id
>   drm: add helper to lookup panel-id
>   drm/bridge: ti-sn65dsi86: use helper to lookup panel-id
> 
>  Documentation/devicetree/bindings/chosen.txt | 69 ++++++++++++++++++++
>  drivers/firmware/efi/libstub/arm-stub.c      | 49 ++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h       |  2 +
>  drivers/firmware/efi/libstub/fdt.c           |  9 +++
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c        |  5 +-
>  drivers/gpu/drm/drm_of.c                     | 21 ++++++
>  include/drm/drm_of.h                         |  7 ++
>  7 files changed, 160 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart
