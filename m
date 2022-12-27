Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0345656CA3
	for <lists+linux-efi@lfdr.de>; Tue, 27 Dec 2022 16:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiL0Pkw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Dec 2022 10:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiL0Pkk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Dec 2022 10:40:40 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD910F6;
        Tue, 27 Dec 2022 07:40:39 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id d9-20020a4aa589000000b004af737509f4so2258077oom.11;
        Tue, 27 Dec 2022 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ouPAFIFSU3MQAiK1xJVbOwuXPXn5HoVK6C46xu1o1c=;
        b=CXvzElqi/ptNRUT7Zn5FvHpvMBO954hnAuTdtLxY0UE5/3zSpUvZtAKaqEvd0OCEjD
         kQ6/JlF6oo4Rja2GmcCBX7KBHWY+qRpIgiH6bdUkVkYyS8CbiLvL0JnBTOtsIExCg/MH
         dxvBthnYBfGnpTRbhwYR1+6fQB9AjANKJYA6bmfQfbkSVs63IPeOAznoFxpSOqO6rGsx
         +SqQ6CFOPH0eCSHqDBEVNxx9g1/p9M5tKRLn6geHt+URDUauce0XTmHET1/C5fknvsXc
         vySZLgV8UnKBJ/afoeCwhyDWe9p5CzHityCzkEPV0twWY5JjFEKZAiAlfnzcTafFVWBq
         aVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ouPAFIFSU3MQAiK1xJVbOwuXPXn5HoVK6C46xu1o1c=;
        b=iSXy0glY281Nj4lSXi4hhm2p6r6Ib1ZLtuR2ztLx2capbRuTVpSq49sBcGouYlprSt
         T2GeG/enN7P70oUiOzXaj578rWdq7rdLYv7v8WuQ4KUI/8A924iuW21Hg4xOtaHvcP7X
         xgKXrBKLw4fyFxPSpvu5zKHsCTCDb9ZKIdrK2eGLxZgnGvGfqGM/xUNbcweYRUwmLYSp
         p85Zw659rqV4kiccMV10ytbfqzBnr+lNrbOKV3z/bxgvEiSo4w7Obt3D8s9FFmBdvGky
         2z4U20cUerQAD6eRtsgHkfgnb1W273YnUznL2sirVkv0Z6ANICsxQe79R028NMj4bYYt
         JcGQ==
X-Gm-Message-State: AFqh2kp3YwzrkHBbO95pe7JUxb2XZuaJoq1WD4PI6bR6CVgf5rrrd/0k
        AnJDJrLUhM5/pOQCNaiV4jOMCSHLdK5+S4f6pUY=
X-Google-Smtp-Source: AMrXdXvha95DjqId+By0Lm+rh7Tb1qN5wm0i6d/Us76SgbzLq95eU+3fCc+9Z0dxZZnTKPiTcymtQ73NX23y1wFNKzM=
X-Received: by 2002:a4a:dccc:0:b0:4a3:e877:b2c8 with SMTP id
 h12-20020a4adccc000000b004a3e877b2c8mr1079528oou.97.1672155638662; Tue, 27
 Dec 2022 07:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20221222183012.1046-1-mario.limonciello@amd.com>
 <2761b1e1-508d-2c2c-f2d8-6f1be536723e@suse.de> <f9b40837-ee2b-76fb-0ec1-d7dfda4ffb7e@amd.com>
In-Reply-To: <f9b40837-ee2b-76fb-0ec1-d7dfda4ffb7e@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 27 Dec 2022 10:40:27 -0500
Message-ID: <CADnq5_M42GQhVquw5BM+P-6NKmdZ6yj8czq=s5iXVAmVOexAkw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Recover from failure to probe GPU
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-efi@vger.kernel.org,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Dec 25, 2022 at 10:31 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 24.12.22 um 10:34 schrieb Thomas Zimmermann:
> > Hi
> >
> > Am 22.12.22 um 19:30 schrieb Mario Limonciello:
> >> One of the first thing that KMS drivers do during initialization is
> >> destroy the system firmware framebuffer by means of
> >> `drm_aperture_remove_conflicting_pci_framebuffers`
> >>
> >> This means that if for any reason the GPU failed to probe the user
> >> will be stuck with at best a screen frozen at the last thing that
> >> was shown before the KMS driver continued it's probe.
> >>
> >> The problem is most pronounced when new GPU support is introduced
> >> because users will need to have a recent linux-firmware snapshot
> >> on their system when they boot a kernel with matching support.
> >>
> >> However the problem is further exaggerated in the case of amdgpu becau=
se
> >> it has migrated to "IP discovery" where amdgpu will attempt to load
> >> on "ALL" AMD GPUs even if the driver is missing support for IP blocks
> >> contained in that GPU.
> >>
> >> IP discovery requires some probing and isn't run until after the
> >> framebuffer has been destroyed.
> >>
> >> This means a situation can occur where a user purchases a new GPU not
> >> yet supported by a distribution and when booting the installer it will
> >> "freeze" even if the distribution doesn't have the matching kernel
> >> support
> >> for those IP blocks.
> >>
> >> The perfect example of this is Ubuntu 21.10 and the new dGPUs just
> >> launched by AMD.  The installation media ships with kernel 5.19 (which
> >> has IP discovery) but the amdgpu support for those IP blocks landed in
> >> kernel 6.0. The matching linux-firmware was released after 21.10's
> >> launch.
> >> The screen will freeze without nomodeset. Even if a user manages to
> >> install
> >> and then upgrades to kernel 6.0 after install they'll still have the
> >> problem of missing firmware, and the same experience.
> >>
> >> This is quite jarring for users, particularly if they don't know
> >> that they have to use "nomodeset" to install.
> >>
> >> To help the situation, allow drivers to re-run the init process for th=
e
> >> firmware framebuffer during a failed probe. As this problem is most
> >> pronounced with amdgpu, this is the only driver changed.
> >>
> >> But if this makes sense more generally for other KMS drivers, the call
> >> can be added to the cleanup routine for those too.
> >
> > Just a quick drive-by comment: as Javier noted, at some point while
> > probing, your driver has changed the device' state and the system FB
> > will be gone. you cannot reestablish the sysfb after that.
>
> I was about to note exactly that as well. This effort here is
> unfortunately pretty pointless.
>
> >
> > You are, however free to read device state at any time, as long as it
> > has no side effects.
> >
> > So why not just move the call to
> > drm_aperture_remove_conflicting_pci_framebuffers() to a later point
> > when you know that your driver supports the hardware? That's the
> > solution we always proposed to this kind of problem. It's safe and
> > won't require any changes to the aperture helpers.
>
> if I'm not completely mistaken that's a little bit tricky. Currently
> it's not possible to read the discovery table before disabling the VGA
> and/or current framebuffer.
>
> We might be able to do this, but it's probably not easy.


It should be possible.  It's populated by the PSP/VBIOS at power up,
so all you need to do is read the right offset in vram.  For
firmwares, we currently read them from the filesystem from the
relevant IP code, but we could also just read it in amdgpu_discovery.c
when we walk the IP discovery table.

Alex


>
> Regards,
> Christian.
>
>
> >
> > Best regards
> > Thomas
> >
> >>
> >> Here is a sample of what happens with missing GPU firmware and this
> >> series:
> >>
> >> [    5.950056] amdgpu 0000:63:00.0: vgaarb: deactivate vga console
> >> [    5.950114] amdgpu 0000:63:00.0: enabling device (0006 -> 0007)
> >> [    5.950883] [drm] initializing kernel modesetting (YELLOW_CARP
> >> 0x1002:0x1681 0x17AA:0x22F1 0xD2).
> >> [    5.952954] [drm] register mmio base: 0xB0A00000
> >> [    5.952958] [drm] register mmio size: 524288
> >> [    5.954633] [drm] add ip block number 0 <nv_common>
> >> [    5.954636] [drm] add ip block number 1 <gmc_v10_0>
> >> [    5.954637] [drm] add ip block number 2 <navi10_ih>
> >> [    5.954638] [drm] add ip block number 3 <psp>
> >> [    5.954639] [drm] add ip block number 4 <smu>
> >> [    5.954641] [drm] add ip block number 5 <dm>
> >> [    5.954642] [drm] add ip block number 6 <gfx_v10_0>
> >> [    5.954643] [drm] add ip block number 7 <sdma_v5_2>
> >> [    5.954644] [drm] add ip block number 8 <vcn_v3_0>
> >> [    5.954645] [drm] add ip block number 9 <jpeg_v3_0>
> >> [    5.954663] amdgpu 0000:63:00.0: amdgpu: Fetched VBIOS from VFCT
> >> [    5.954666] amdgpu: ATOM BIOS: 113-REMBRANDT-X37
> >> [    5.954677] [drm] VCN(0) decode is enabled in VM mode
> >> [    5.954678] [drm] VCN(0) encode is enabled in VM mode
> >> [    5.954680] [drm] JPEG decode is enabled in VM mode
> >> [    5.954681] amdgpu 0000:63:00.0: amdgpu: Trusted Memory Zone (TMZ)
> >> feature disabled as experimental (default)
> >> [    5.954683] amdgpu 0000:63:00.0: amdgpu: PCIE atomic ops is not
> >> supported
> >> [    5.954724] [drm] vm size is 262144 GB, 4 levels, block size is
> >> 9-bit, fragment size is 9-bit
> >> [    5.954732] amdgpu 0000:63:00.0: amdgpu: VRAM: 512M
> >> 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
> >> [    5.954735] amdgpu 0000:63:00.0: amdgpu: GART: 1024M
> >> 0x0000000000000000 - 0x000000003FFFFFFF
> >> [    5.954738] amdgpu 0000:63:00.0: amdgpu: AGP: 267419648M
> >> 0x000000F800000000 - 0x0000FFFFFFFFFFFF
> >> [    5.954747] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
> >> [    5.954750] [drm] RAM width 256bits LPDDR5
> >> [    5.954834] [drm] amdgpu: 512M of VRAM memory ready
> >> [    5.954838] [drm] amdgpu: 15680M of GTT memory ready.
> >> [    5.954873] [drm] GART: num cpu pages 262144, num gpu pages 262144
> >> [    5.955333] [drm] PCIE GART of 1024M enabled (table at
> >> 0x000000F41FC00000).
> >> [    5.955502] amdgpu 0000:63:00.0: Direct firmware load for
> >> amdgpu/yellow_carp_toc.bin failed with error -2
> >> [    5.955505] amdgpu 0000:63:00.0: amdgpu: fail to request/validate
> >> toc microcode
> >> [    5.955510] [drm:psp_sw_init [amdgpu]] *ERROR* Failed to load psp
> >> firmware!
> >> [    5.955725] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init
> >> of IP block <psp> failed -2
> >> [    5.955952] amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_init fail=
ed
> >> [    5.955954] amdgpu 0000:63:00.0: amdgpu: Fatal error during GPU ini=
t
> >> [    5.955957] amdgpu 0000:63:00.0: amdgpu: amdgpu: finishing device.
> >> [    5.971162] efifb: probing for efifb
> >> [    5.971281] efifb: showing boot graphics
> >> [    5.974803] efifb: framebuffer at 0x910000000, using 20252k, total
> >> 20250k
> >> [    5.974805] efifb: mode is 2880x1800x32, linelength=3D11520, pages=
=3D1
> >> [    5.974807] efifb: scrolling: redraw
> >> [    5.974807] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
> >> [    5.974974] Console: switching to colour frame buffer device 180x56
> >> [    5.978181] fb0: EFI VGA frame buffer device
> >> [    5.978199] amdgpu: probe of 0000:63:00.0 failed with error -2
> >> [    5.978285] [drm] amdgpu: ttm finalized
> >>
> >> Now if the user loads the firmware into the system they can re-load th=
e
> >> driver or re-attach using sysfs and it gracefully recovers.
> >>
> >> [  665.080480] [drm] Initialized amdgpu 3.49.0 20150101 for
> >> 0000:63:00.0 on minor 0
> >> [  665.090075] fbcon: amdgpudrmfb (fb0) is primary device
> >> [  665.090248] [drm] DSC precompute is not needed.
> >>
> >> Mario Limonciello (2):
> >>    firmware: sysfb: Allow re-creating system framebuffer after init
> >>    drm/amd: Re-create firmware framebuffer on failure to probe
> >>
> >>   drivers/firmware/efi/sysfb_efi.c        |  6 +++---
> >>   drivers/firmware/sysfb.c                | 15 ++++++++++++++-
> >>   drivers/firmware/sysfb_simplefb.c       |  4 ++--
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
> >>   include/linux/sysfb.h                   |  5 +++++
> >>   5 files changed, 26 insertions(+), 6 deletions(-)
> >>
> >>
> >> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> >
>
