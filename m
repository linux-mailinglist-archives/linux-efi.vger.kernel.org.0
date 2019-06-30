Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5856B5B17D
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2019 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfF3Uge (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jun 2019 16:36:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33760 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfF3Ugd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jun 2019 16:36:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id h24so9492169qto.0;
        Sun, 30 Jun 2019 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzMoDY2PVdsaZxFUKIEpPbUDj5ALelERAN3KJa8FN/g=;
        b=UZNSu2Oc32IchdcgBkZBLJZf2WcpYM2hi5A6sV0emvQLkxDtWCGnoNRGiNzSE0t4pa
         YIX3DjFpX/187JCvcH1aeMTVrjNYEnxKR58L33zl3vThrzv67djM6PvwI90+47wGuhEa
         AMfyyrKD10l76y5uNo+x5Pt2BI6oc9RQILmeAW6fyaYDgvp5TtgANjRtoVgr8bCnA+Ix
         Kg1aBL9B19wcj4yz1RUKpj5dPIN9vSU0XUDtQQ9Yl+ZDdhvtj2xRRS7MBHIsCtBl7nMc
         p78dsh3opbJdC7eF6/BFdoRs94qJ7VzmXmZkD8a/7676iDcxhH66XfPj5lzVhrB+2s8U
         PCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzMoDY2PVdsaZxFUKIEpPbUDj5ALelERAN3KJa8FN/g=;
        b=k6BVe3sFlsJcW37jVKgbb7kyVvIkrQGIakgKVhriOU12HpLyZlU56e0OarV4mwq2qv
         LUorY2bPiqZUM0xJwR94y7VXqBTUw7+NHlN3igRdBK4j+qHQzbbq5NohxweVAxl/Edh6
         SGHzkvTgag9gcLzXBBcB0oXN59/b815VPmA3got1+6vAwLwdRNNhjN6OnWGKAEV21gE+
         p8qh0bTDilZQb+ZsUHSoErwCHjNBqcQs43dLsVzDw9nFLjlzb5irenQJNyPyTGJPz2AB
         CeI8HDLzYJvsg+d4XvhKXVjS4RMYvG/xttMvhKANy6kxQ3XdNT0SSKLBZko99HUB3k/e
         HP0Q==
X-Gm-Message-State: APjAAAUYTJPuq2x2fXnHK0DCNXmxvV3iI6GwJxmSN2P3k1i0O0+6zh54
        GzwbAlPQBShfHX9nPy6n7T4=
X-Google-Smtp-Source: APXvYqwQfaHdQ/vGbGlCFGNupx1trzPU/pHEUuoPA5ez15XzPmvs8A2wjIpUozB0pTNRCtr8UHzWUA==
X-Received: by 2002:ac8:2971:: with SMTP id z46mr17115175qtz.322.1561926992481;
        Sun, 30 Jun 2019 13:36:32 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id j2sm4167172qtb.89.2019.06.30.13.36.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 13:36:31 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Ingo Molnar <mingo@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE
        (EFI)), linux-kernel@vger.kernel.org (open list),
        Lukas Wunner <lukas@wunner.de>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/4] drm+dt+efi: support devices with multiple possible panels
Date:   Sun, 30 Jun 2019 13:36:04 -0700
Message-Id: <20190630203614.5290-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Now that we can deal gracefully with bootloader (firmware) initialized
display on aarch64 laptops[1], the next step is to deal with the fact
that the same model of laptop can have one of multiple different panels.
(For the yoga c630 that I have, I know of at least two possible panels,
there might be a third.)

This is actually a scenario that comes up frequently in phones and
tablets as well, so it is useful to have an upstream solution for this.

The basic idea is to add a 'panel-id' property in dt chosen node, and
use that to pick the endpoint we look at when loading the panel driver,
e.g.

/ {
	chosen {
		panel-id = <0xc4>;
	};

	ivo_panel {
		compatible = "ivo,m133nwf4-r0";
		power-supply = <&vlcm_3v3>;
		no-hpd;

		ports {
			port {
				ivo_panel_in_edp: endpoint {
					remote-endpoint = <&sn65dsi86_out_ivo>;
				};
			};
		};
	};

	boe_panel {
		compatible = "boe,nv133fhm-n61";
		power-supply = <&vlcm_3v3>;
		no-hpd;

		ports {
			port {
				boe_panel_in_edp: endpoint {
					remote-endpoint = <&sn65dsi86_out_boe>;
				};
			};
		};
	};

	sn65dsi86: bridge@2c {
		compatible = "ti,sn65dsi86";

		...

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			...

			port@1 {
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <1>;

				endpoint@c4 {
					reg = <0xc4>;
					remote-endpoint = <&boe_panel_in_edp>;
				};

				endpoint@c5 {
					reg = <0xc5>;
					remote-endpoint = <&ivo_panel_in_edp>;
				};
			};
		};
	}
};

Note that the panel-id is potentially a sparse-int.  The values I've
seen so far on aarch64 laptops are:

  * 0xc2
  * 0xc3
  * 0xc4
  * 0xc5
  * 0x8011
  * 0x8012
  * 0x8055
  * 0x8056

At least on snapdragon aarch64 laptops, they can be any u32 value.

However, on these laptops, the bootloader/firmware is not populating the
chosen node, but instead providing an "UEFIDisplayInfo" variable, which
contains the panel id.  Unfortunately EFI variables are only available
before ExitBootServices, so the second patch checks for this variable
before EBS and populates the /chosen/panel-id variable.

[1] https://patchwork.freedesktop.org/series/63001/

Rob Clark (4):
  dt-bindings: chosen: document panel-id binding
  efi/libstub: detect panel-id
  drm: add helper to lookup panel-id
  drm/bridge: ti-sn65dsi86: use helper to lookup panel-id

 Documentation/devicetree/bindings/chosen.txt | 69 ++++++++++++++++++++
 drivers/firmware/efi/libstub/arm-stub.c      | 49 ++++++++++++++
 drivers/firmware/efi/libstub/efistub.h       |  2 +
 drivers/firmware/efi/libstub/fdt.c           |  9 +++
 drivers/gpu/drm/bridge/ti-sn65dsi86.c        |  5 +-
 drivers/gpu/drm/drm_of.c                     | 21 ++++++
 include/drm/drm_of.h                         |  7 ++
 7 files changed, 160 insertions(+), 2 deletions(-)

-- 
2.20.1

