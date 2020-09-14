Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42C5269548
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgINTIk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTIg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 15:08:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DFAC06174A
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 12:08:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w186so1375871qkd.1
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LtBpm0EvivjYpJpAii07XRxOpir2Kawb84q3ZuAy/j0=;
        b=qwS/uFr6qA0T9qkSloRNAsc+klQIObre3z7r+i9CIpUR9bzizjNAOtgNcRdfoxDlga
         8EZr4XC8OdSB9Kzpio20LV1q4P1elZ1UsMhpxiT5KmpxhpVyq2LiDf7ElFNUK2jjxl5n
         n56Lva9nIabcXXjwygdEoghIkS/YeO8rp/3a/fKR78OdSffzzpQoVqRDvojthHPl0VZc
         9+rHwuTlm/5ftszUII+Y2UqC4rR00gUu+yBwho69X1mXVW8V1CWn6j1xD1MQofwbnjSI
         jgvL0nawCBPd1QgjatO4Q5nxeelpOkewtchdv3fHybjcsPHHJ2U33sbc/lk45hDg95dQ
         ZiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LtBpm0EvivjYpJpAii07XRxOpir2Kawb84q3ZuAy/j0=;
        b=qBN3hx81uuy6HklvE6d9TYCKW9+x0m2BZ8yUZvVusui1nzN7lwX2SnW/iI3k8viAat
         ZbMAMnpAVYgtcwQ+8GeWC+LsBDVWz4QFSuMtxyFRSxyE7FYa1DW5nf0SUdfmADam60hN
         PsF//8H1Lc8N8Y3SqPvqZu5bIM6BX1VwYS+tkuaVJwZuvhGteDxKaGfg32hWBkeY034Z
         ifrt3DYq1EzXifDd28iQLJxiH0myNm25EWfMn/IH5IYoT1NsgnEa5s+gacoIQ1JGcFAg
         PXSaK+5+GKuwWb3CRovSbCm0ApwS/+02JZcccRAQAEeKs8wfGM6xW91gQuTXoPQPDgi5
         8mbg==
X-Gm-Message-State: AOAM530YEgQYq8eXWUmzwBK5atNkBBI8f0f4njxBKvyXLiJj6n2TX8uK
        kfXiCOmi1v5uoSeJO9HBBgk=
X-Google-Smtp-Source: ABdhPJybBfU4EDJlCHc5wM/hqNktf0A8wHgRdkwnWUswl9ixWL8p2dzTxLWbHeE9taRymyLt5uRYuQ==
X-Received: by 2002:a37:38f:: with SMTP id 137mr13858780qkd.416.1600110515468;
        Mon, 14 Sep 2020 12:08:35 -0700 (PDT)
Received: from ?IPv6:2601:14a:c300:64e:44da:ed5:a569:62ca? ([2601:14a:c300:64e:44da:ed5:a569:62ca])
        by smtp.gmail.com with ESMTPSA id t11sm9937857qkm.55.2020.09.14.12.08.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 12:08:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: EFI regression for efi=noruntime support
From:   Branden Sherrell <sherrellbc@gmail.com>
In-Reply-To: <CAMj1kXEmw08Sed7CfgzBcjD1-WSNW9=Z27-0m4UKdfR5VCmFGg@mail.gmail.com>
Date:   Mon, 14 Sep 2020 15:08:33 -0400
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <476F32F3-54E7-4B96-B857-09B0AB4B4DAB@gmail.com>
References: <AE217103-C96F-4AFC-8417-83EC11962004@gmail.com>
 <CAMj1kXEmw08Sed7CfgzBcjD1-WSNW9=Z27-0m4UKdfR5VCmFGg@mail.gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

That fixed it. Thanks for the quick look and patch.=20

Branden

> On Sep 14, 2020, at 2:27 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Mon, 14 Sep 2020 at 20:15, Branden Sherrell <sherrellbc@gmail.com> =
wrote:
>>=20
>> An EFI-related regression appears to have made its way in from =
f88814cc2578c121e6edef686365036db72af0ed:
>>=20
>> Author: Ard Biesheuvel <ardb@kernel.org> Date: Wed Jul 8 13:01:57 =
2020 +0300 efi/efivars:
>> Expose RT service availability via efivars abstraction
>>=20
>>=20
>> On the RockChip rk3399 (ARMv8) port the EFI subsystem claims the =
reboot callback despite no runtime support. Ordinarily one might use =
efi=3Dnoruntime or noefi to disable this, but the boot augment appears =
to now be outright ignored (on this system, at least). You might imagine =
this causes issue on a uboot'd system that does not have runtime =
services. The manifestation of this bug is an iabt with PC=3D0 =
originating in efivar_entry_set_safe. This function eventually attempts =
to call the NULL entry ops->set_variable.
>>=20
>> [   41.231673] Unable to handle kernel NULL pointer dereference at =
virtual address 0000000000000000
>> [   41.232436] Mem abort info:
>> [   41.232682]   ESR =3D 0x86000004
>> [   41.232951]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
>> [   41.233413]   SET =3D 0, FnV =3D 0
>> [   41.233681]   EA =3D 0, S1PTW =3D 0
>> [   41.233956] user pgtable: 4k pages, 48-bit VAs, =
pgdp=3D00000000f02eb000
>> [   41.234516] [0000000000000000] pgd=3D0000000000000000, =
p4d=3D0000000000000000
>> [   41.235111] Internal error: Oops: 86000004 [#1] SMP
>> [   41.235536] Modules linked in: rt2800usb rt2x00usb rt2800lib =
rt2x00lib rc_cec mac80211 snd_soc_hdmi_codec dw_hdmi_i2s_audio =
dw_hdmi_cec rockchipdrm realtek dw_mipi_dsi hantro_vpu(C) dw_hdmi =
hci_uart rockchip_vdec(C) rockchip_rga analogix_dp cfg80211 cec btqca =
btbcm v4l2_h264 videobuf2_dma_sg pwm_fan btintel rc_core v4l2_mem2mem =
videobuf2_vmalloc videobuf2_dma_contig bluetooth dwmac_rk =
videobuf2_memops videobuf2_v4l2 stmmac_platform videobuf2_common libarc4 =
drm_kms_helper snd_soc_audio_graph_card snd_soc_simple_card stmmac =
snd_soc_simple_card_utils syscopyarea sysfillrect sysimgblt panfrost =
fb_sys_fops ecdh_generic mdio_xpcs videodev phylink gpu_sched ecc =
snd_soc_rockchip_i2s rfkill mc snd_soc_rockchip_pcm dw_wdt =
rockchip_thermal rtc_rk808 rockchip_saradc drm gpio_keys
>> [   41.241462] CPU: 5 PID: 1 Comm: shutdown Tainted: G         C      =
  5.8.8-1-ARCH #1
>> [   41.242135] Hardware name: pine64 =
rockpro64_rk3399/rockpro64_rk3399, BIOS 2020.10-rc4-dirty 09/11/2020
>> [   41.242944] pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=3D--)
>> [   41.243431] pc : 0x0
>> [   41.243631] lr : efivar_entry_set_safe+0xc8/0x1a0
>> [   41.244041] sp : ffff80001254bbe0
>> [   41.244331] x29: ffff80001254bbe0 x28: ffff0000f2f8e3c0
>> [   41.244794] x27: 0000000000000000 x26: ffff0000f11af418
>> [   41.245257] x25: ffff8000124c0000 x24: ffff8000124c0b50
>> [   41.245720] x23: ffff0000f11af418 x22: ffff800012387230
>> [   41.246183] x21: 0000000000000007 x20: ffff0000f11af000
>> [   41.246646] x19: 000000000000000e x18: 0000000000000030
>> [   41.247109] x17: 0000000000000000 x16: 0000000000000000
>> [   41.247572] x15: ffff0000f2f8e8e0 x14: ffffffffffffffff
>> [   41.248034] x13: ffff80009254b9e7 x12: 0000000000000030
>> [   41.248497] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>> [   41.248960] x9 : ffff800010d8bb94 x8 : 41cf0a4c4a67b082
>> [   41.249423] x7 : ffff8000124c0b78 x6 : ffff0000f11af418
>> [   41.249886] x5 : 0000000000000000 x4 : ffff0000f11af418
>> [   41.250349] x3 : 000000000000000e x2 : 0000000000000007
>> [   41.250811] x1 : ffff80001254bc30 x0 : ffff0000f11af000
>> [   41.251275] Call trace:
>> [   41.251491]  0x0
>> [   41.251655]  efibc_set_variable+0xf0/0x170
>> [   41.252013]  efibc_reboot_notifier_call+0x44/0x80
>> [   41.252427]  blocking_notifier_call_chain+0x78/0xb0
>> [   41.252852]  __do_sys_reboot+0x1cc/0x290
>> [   41.253195]  __arm64_sys_reboot+0x30/0x40
>> [   41.253547]  el0_svc_common.constprop.0+0x7c/0x140
>> [   41.253965]  do_el0_svc+0x28/0xb0
>> [   41.254257]  el0_sync_handler+0x98/0x278
>> [   41.254599]  el0_sync+0x158/0x180
>> [   41.254891] Code: bad PC value
>> [   41.255160] ---[ end trace 1fafcf21a783a644 ]---
>> [   41.255617] Kernel panic - not syncing: Attempted to kill init! =
exitcode=3D0x0000000b
>> [   41.256283] SMP: stopping secondary CPUs
>> [   41.256735] Kernel Offset: disabled
>> [   41.257040] CPU features: 0x240022,21006008
>> [   41.257406] Memory Limit: none
>> [   41.257681] ---[ end Kernel panic - not syncing: Attempted to kill =
init! exitcode=3D0x0000000b ]---
>>=20
>> I did not spend too much time poking around, but I did note that if =
one builds a kernel that forces the efibc_init to return ENODEV to =
prevent reboot registration, the system will properly consult PSCI to =
handle the event (as is expected for the rk3399 per the device tree). =
This observed behavior is accurate at least through 5.9.0-rc4. A test of =
the previous commit (8778eb0927ddcd3f431805c37b78fa56481aeed9) confirms =
an uneventful reboot for this device.
>> The board configuration is the RockPro64, which has a device tree =
present in the kernel sources. My configuration in particular was using =
the latest Grub to EFI boot Linux after having itself been loaded by =
uboot.
>>=20
>>=20
>=20
> This looks like an oversight in the efibc driver.
>=20
> Does the change below fix your issue?
>=20
> diff --git a/drivers/firmware/efi/efibc.c =
b/drivers/firmware/efi/efibc.c
> index 35dccc88ac0a..15a47539dc56 100644
> --- a/drivers/firmware/efi/efibc.c
> +++ b/drivers/firmware/efi/efibc.c
> @@ -84,7 +84,7 @@ static int __init efibc_init(void)
> {
>        int ret;
>=20
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +       if (!efivars_kobject() || !efivar_supports_writes())
>                return -ENODEV;
>=20
>        ret =3D register_reboot_notifier(&efibc_reboot_notifier);

