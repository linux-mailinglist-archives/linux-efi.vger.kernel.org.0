Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD92694D2
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgINS1q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 14:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgINS1m (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 14:27:42 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3E421974
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600108059;
        bh=9zQyAdaFrGUUQcLYXuH5+uMSf+npN1mAx2Zcifw74OY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GCTsQnJScrYqKDuvULAAKyFuShwxgrGxtPilx4zYepxfBLYz7LhP7cEBxVRQyxSf+
         6k7kMrAtIYfLNg9cCF1/IEkBUHhM+NX3ZwI1GEAvcXy4Q4dSHXcd4fXCIGoPsrE5D9
         l9niMYoNU47nToNlDL0Vf+hvqv6dE2M7SxEWmFzE=
Received: by mail-oi1-f177.google.com with SMTP id i17so860831oig.10
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 11:27:39 -0700 (PDT)
X-Gm-Message-State: AOAM530RM/Ovyozzyen4UJNrwxMuFFzjfkNYPqX6UBMKNbmfguww019w
        LcDurNrIXguzazX8TFHMqaog1ENt0oITPH1LZ3E=
X-Google-Smtp-Source: ABdhPJwliVfikFe9Ge/DB+qMo4KZOH/wzBCGHdVkTZb0I+s77o85GNgg+kIVrzixihaMscTLMDh7E7+hxWXoZn4ymIg=
X-Received: by 2002:aca:d845:: with SMTP id p66mr418694oig.47.1600108058712;
 Mon, 14 Sep 2020 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <AE217103-C96F-4AFC-8417-83EC11962004@gmail.com>
In-Reply-To: <AE217103-C96F-4AFC-8417-83EC11962004@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Sep 2020 21:27:27 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEmw08Sed7CfgzBcjD1-WSNW9=Z27-0m4UKdfR5VCmFGg@mail.gmail.com>
Message-ID: <CAMj1kXEmw08Sed7CfgzBcjD1-WSNW9=Z27-0m4UKdfR5VCmFGg@mail.gmail.com>
Subject: Re: EFI regression for efi=noruntime support
To:     Branden Sherrell <sherrellbc@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 14 Sep 2020 at 20:15, Branden Sherrell <sherrellbc@gmail.com> wrote=
:
>
> An EFI-related regression appears to have made its way in from f88814cc25=
78c121e6edef686365036db72af0ed:
>
> Author: Ard Biesheuvel <ardb@kernel.org> Date: Wed Jul 8 13:01:57 2020 +0=
300 efi/efivars:
> Expose RT service availability via efivars abstraction
>
>
> On the RockChip rk3399 (ARMv8) port the EFI subsystem claims the reboot c=
allback despite no runtime support. Ordinarily one might use efi=3Dnoruntim=
e or noefi to disable this, but the boot augment appears to now be outright=
 ignored (on this system, at least). You might imagine this causes issue on=
 a uboot'd system that does not have runtime services. The manifestation of=
 this bug is an iabt with PC=3D0 originating in efivar_entry_set_safe. This=
 function eventually attempts to call the NULL entry ops->set_variable.
>
> [   41.231673] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
> [   41.232436] Mem abort info:
> [   41.232682]   ESR =3D 0x86000004
> [   41.232951]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> [   41.233413]   SET =3D 0, FnV =3D 0
> [   41.233681]   EA =3D 0, S1PTW =3D 0
> [   41.233956] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000f02eb00=
0
> [   41.234516] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [   41.235111] Internal error: Oops: 86000004 [#1] SMP
> [   41.235536] Modules linked in: rt2800usb rt2x00usb rt2800lib rt2x00lib=
 rc_cec mac80211 snd_soc_hdmi_codec dw_hdmi_i2s_audio dw_hdmi_cec rockchipd=
rm realtek dw_mipi_dsi hantro_vpu(C) dw_hdmi hci_uart rockchip_vdec(C) rock=
chip_rga analogix_dp cfg80211 cec btqca btbcm v4l2_h264 videobuf2_dma_sg pw=
m_fan btintel rc_core v4l2_mem2mem videobuf2_vmalloc videobuf2_dma_contig b=
luetooth dwmac_rk videobuf2_memops videobuf2_v4l2 stmmac_platform videobuf2=
_common libarc4 drm_kms_helper snd_soc_audio_graph_card snd_soc_simple_card=
 stmmac snd_soc_simple_card_utils syscopyarea sysfillrect sysimgblt panfros=
t fb_sys_fops ecdh_generic mdio_xpcs videodev phylink gpu_sched ecc snd_soc=
_rockchip_i2s rfkill mc snd_soc_rockchip_pcm dw_wdt rockchip_thermal rtc_rk=
808 rockchip_saradc drm gpio_keys
> [   41.241462] CPU: 5 PID: 1 Comm: shutdown Tainted: G         C        5=
.8.8-1-ARCH #1
> [   41.242135] Hardware name: pine64 rockpro64_rk3399/rockpro64_rk3399, B=
IOS 2020.10-rc4-dirty 09/11/2020
> [   41.242944] pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=3D--)
> [   41.243431] pc : 0x0
> [   41.243631] lr : efivar_entry_set_safe+0xc8/0x1a0
> [   41.244041] sp : ffff80001254bbe0
> [   41.244331] x29: ffff80001254bbe0 x28: ffff0000f2f8e3c0
> [   41.244794] x27: 0000000000000000 x26: ffff0000f11af418
> [   41.245257] x25: ffff8000124c0000 x24: ffff8000124c0b50
> [   41.245720] x23: ffff0000f11af418 x22: ffff800012387230
> [   41.246183] x21: 0000000000000007 x20: ffff0000f11af000
> [   41.246646] x19: 000000000000000e x18: 0000000000000030
> [   41.247109] x17: 0000000000000000 x16: 0000000000000000
> [   41.247572] x15: ffff0000f2f8e8e0 x14: ffffffffffffffff
> [   41.248034] x13: ffff80009254b9e7 x12: 0000000000000030
> [   41.248497] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [   41.248960] x9 : ffff800010d8bb94 x8 : 41cf0a4c4a67b082
> [   41.249423] x7 : ffff8000124c0b78 x6 : ffff0000f11af418
> [   41.249886] x5 : 0000000000000000 x4 : ffff0000f11af418
> [   41.250349] x3 : 000000000000000e x2 : 0000000000000007
> [   41.250811] x1 : ffff80001254bc30 x0 : ffff0000f11af000
> [   41.251275] Call trace:
> [   41.251491]  0x0
> [   41.251655]  efibc_set_variable+0xf0/0x170
> [   41.252013]  efibc_reboot_notifier_call+0x44/0x80
> [   41.252427]  blocking_notifier_call_chain+0x78/0xb0
> [   41.252852]  __do_sys_reboot+0x1cc/0x290
> [   41.253195]  __arm64_sys_reboot+0x30/0x40
> [   41.253547]  el0_svc_common.constprop.0+0x7c/0x140
> [   41.253965]  do_el0_svc+0x28/0xb0
> [   41.254257]  el0_sync_handler+0x98/0x278
> [   41.254599]  el0_sync+0x158/0x180
> [   41.254891] Code: bad PC value
> [   41.255160] ---[ end trace 1fafcf21a783a644 ]---
> [   41.255617] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x0000000b
> [   41.256283] SMP: stopping secondary CPUs
> [   41.256735] Kernel Offset: disabled
> [   41.257040] CPU features: 0x240022,21006008
> [   41.257406] Memory Limit: none
> [   41.257681] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x0000000b ]---
>
> I did not spend too much time poking around, but I did note that if one b=
uilds a kernel that forces the efibc_init to return ENODEV to prevent reboo=
t registration, the system will properly consult PSCI to handle the event (=
as is expected for the rk3399 per the device tree). This observed behavior =
is accurate at least through 5.9.0-rc4. A test of the previous commit (8778=
eb0927ddcd3f431805c37b78fa56481aeed9) confirms an uneventful reboot for thi=
s device.
> The board configuration is the RockPro64, which has a device tree present=
 in the kernel sources. My configuration in particular was using the latest=
 Grub to EFI boot Linux after having itself been loaded by uboot.
>
>

This looks like an oversight in the efibc driver.

Does the change below fix your issue?

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 35dccc88ac0a..15a47539dc56 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -84,7 +84,7 @@ static int __init efibc_init(void)
 {
        int ret;

-       if (!efi_enabled(EFI_RUNTIME_SERVICES))
+       if (!efivars_kobject() || !efivar_supports_writes())
                return -ENODEV;

        ret =3D register_reboot_notifier(&efibc_reboot_notifier);
