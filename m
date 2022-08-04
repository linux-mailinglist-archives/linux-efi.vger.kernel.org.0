Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5B5899E2
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiHDJZq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiHDJZn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 05:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D23161DA4
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659605141;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sn2PK1U1cTxC3HWf9q5KgU2qHpjykP3tFNH0DbOVk6s=;
        b=dgAJ4c2sQLQNor7fMyZNN6brtaoza2h6RS0g8m7PxGfxMGwgvjJWGySost3kh8am4dEJ7f
        xhjTWdmAPc03dNYIDvUkvXpBXn2QvxZkojbEpU+IJGz5R71jvp6HDjgQG0qMl1ZcOrBZNs
        RU6RyzX/B2ykEVB0wC97g+WqnQHCrrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-Ytb9r3daNSSF7FrLXKR4tQ-1; Thu, 04 Aug 2022 05:25:40 -0400
X-MC-Unique: Ytb9r3daNSSF7FrLXKR4tQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCFED811E76;
        Thu,  4 Aug 2022 09:25:39 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.252])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85BC040CF8EA;
        Thu,  4 Aug 2022 09:25:38 +0000 (UTC)
Date:   Thu, 4 Aug 2022 10:25:36 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <YuuQb3D/YY1SiUqY@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <YusVVLNbLgsk49PK@zx2c4.com>
 <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 04, 2022 at 10:58:36AM +0200, Laszlo Ersek wrote:
> On 08/04/22 09:03, Michael S. Tsirkin wrote:
> > On Thu, Aug 04, 2022 at 02:44:11AM +0200, Jason A. Donenfeld wrote:
> >> The boot parameter header refers to setup_data at an absolute address,
> >> and each setup_data refers to the next setup_data at an absolute address
> >> too. Currently QEMU simply puts the setup_datas right after the kernel
> >> image, and since the kernel_image is loaded at prot_addr -- a fixed
> >> address knowable to QEMU apriori -- the setup_data absolute address
> >> winds up being just `prot_addr + a_fixed_offset_into_kernel_image`.
> >>
> >> This mostly works fine, so long as the kernel image really is loaded at
> >> prot_addr. However, OVMF doesn't load the kernel at prot_addr, and
> >> generally EFI doesn't give a good way of predicting where it's going to
> >> load the kernel. So when it loads it at some address != prot_addr, the
> >> absolute addresses in setup_data now point somewhere bogus, causing
> >> crashes when EFI stub tries to follow the next link.
> >>
> >> Fix this by placing setup_data at some fixed place in memory, relative
> >> to real_addr, not as part of the kernel image, and then pointing the
> >> setup_data absolute address to that fixed place in memory. This way,
> >> even if OVMF or other chains relocate the kernel image, the boot
> >> parameter still points to the correct absolute address.
> >>
> >> Fixes: 3cbeb52467 ("hw/i386: add device tree support")
> >> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Richard Henderson <richard.henderson@linaro.org>
> >> Cc: Peter Maydell <peter.maydell@linaro.org>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Daniel P. Berrangé <berrange@redhat.com>
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: linux-efi@vger.kernel.org
> >> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > 
> > Didn't read the patch yet.
> > Adding Laszlo.
> 
> As I said in
> <http://mid.mail-archive.com/8bcc7826-91ab-855e-7151-2e9add88025a@redhat.com>,
> I don't believe that the setup_data chaining described in
> <https://www.kernel.org/doc/Documentation/x86/boot.rst> can be made work
> for UEFI guests at all, with QEMU pre-populating the links with GPAs.
> 
> However, rather than introducing a new info channel, or reusing an
> existent one (ACPI linker/loader, GUID-ed structure chaining in pflash),
> for the sake of this feature, I suggest simply disabling this feature
> for UEFI guests. setup_data chaining has not been necessary for UEFI
> guests for years (this is the first time I've heard about it in more
> than a decade), and the particular use case (provide guests with good
> random seed) is solved for UEFI guests via virtio-rng / EFI_RNG_PROTOCOL.
> 
> ... Now, here's my problem: microvm, and Xen.
> 
> As far as I can tell, QEMU can determine (it already does determine)
> whether the guest uses UEFI or not, for the "pc" and "q35" machine
> types. But not for microvm or Xen!
> 
> Namely, from pc_system_firmware_init() [hw/i386/pc_sysfw.c], we can
> derive that
> 
>   pflash_cfi01_get_blk(pcms->flash[0])
> 
> returning NULL vs. non-NULL stands for "BIOS vs. UEFI". Note that this
> is only valid after the inital part of pc_system_firmware_init() has run
> ("Map legacy -drive if=pflash to machine properties"), but that is not a
> problem, given the following call tree:

I don't beleve that's a valid check anymore since Gerd introduced the
ability to load UEFI via -bios, for UEFI builds without persistent
variables. ( a8152c4e4613c70c2f0573a82babbc8acc00cf90 )


> Which is a big problem for my idea, because QEMU has no way of
> identifying whether microvm is going to boot a custom SeaBIOS binary
> (where the current setup_data chaining is OK) or a custom OVMF binary
> (where the current setup_data chaining crashes the guest kernel).
> 
> So I thought that for pc and q35, I should be able to propose a fix,
> based on:
> 
>   pflash_cfi01_get_blk(pcms->flash[0])
> 
> but it turns out I don't know what to do about Xen; and worse, for
> MicroVM, it's currently *impossible* for QEMU to tell apart UEFI from
> other guest firmwares.

Yep, and ultimately the inability to distinguish UEFI vs other firmware
is arguably correct by design, as the QEMU <-> firmware interface is
supposed to be arbitrarily pluggable for any firmware implementation
not  limited to merely UEFI + seabios.

> For now I suggest either reverting the original patch, or at least not
> enabling the knob by default for any machine types. In particular, when
> using MicroVM, the user must leave the knob disabled when direct booting
> a kernel on OVMF, and the user may or may not enable the knob when
> direct booting a kernel on SeaBIOS.

Having it opt-in via a knob would defeat Jason's goal of having the seed
available automatically.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

