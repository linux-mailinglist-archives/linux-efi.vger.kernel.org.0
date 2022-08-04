Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881E0589D32
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiHDOEA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbiHDOEA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 10:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82B0A22506
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659621837;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zt/6rKxlyLvKW3T4jCF0N1zOxUh2xZRvNdkUswbotUI=;
        b=RA+IMvl/fsva9Xlqa1yVKzk28U87IxqQ6DL2cl4MxnCVT4bJlGYEuQzG2nz+gn/EkfNTEK
        /0efiv4gXZ7NznMUdjKk1q8dVTxLMbEGeawtCceyi+aiP1WgT8KeXdYiu3KcWUpSsgMcGI
        bOOj9N4DyvjBxyXiXG0U9uhjZROEqGk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-vWpOr7SdOPa2AcbH0rF01A-1; Thu, 04 Aug 2022 10:03:54 -0400
X-MC-Unique: vWpOr7SdOPa2AcbH0rF01A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E55E23802BA6;
        Thu,  4 Aug 2022 14:03:53 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 241E4C28100;
        Thu,  4 Aug 2022 14:03:50 +0000 (UTC)
Date:   Thu, 4 Aug 2022 15:03:47 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <YuvRw19RHZLF1dgR@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
 <Yuu1kX9CAqSUNNAj@zx2c4.com>
 <Yuu3ee1iB3IoLdZS@redhat.com>
 <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
 <cf60456e-a2cd-a64d-0cee-4bea30708fc9@redhat.com>
 <CAHmME9pUdckUwei234Xdge_G-=b6q2e9a8mTVExrV4WE=6TLig@mail.gmail.com>
 <8254819e-d509-59f4-79e6-e8c0ba4eb2a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8254819e-d509-59f4-79e6-e8c0ba4eb2a6@redhat.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 04, 2022 at 03:56:54PM +0200, Laszlo Ersek wrote:
> On 08/04/22 15:28, Jason A. Donenfeld wrote:
> > On Thu, Aug 4, 2022 at 3:25 PM Laszlo Ersek <lersek@redhat.com> wrote:
> >>
> >> On 08/04/22 14:16, Ard Biesheuvel wrote:
> >>> On Thu, 4 Aug 2022 at 14:11, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>>>
> >>>> On Thu, Aug 04, 2022 at 02:03:29PM +0200, Jason A. Donenfeld wrote:
> >>>>> Hi Daniel,
> >>>>>
> >>>>> On Thu, Aug 04, 2022 at 10:25:36AM +0100, Daniel P. Berrangé wrote:
> >>>>>> Yep, and ultimately the inability to distinguish UEFI vs other firmware
> >>>>>> is arguably correct by design, as the QEMU <-> firmware interface is
> >>>>>> supposed to be arbitrarily pluggable for any firmware implementation
> >>>>>> not  limited to merely UEFI + seabios.
> >>>>>
> >>>>> Indeed, I agree with this.
> >>>>>
> >>>>>>
> >>>>>>> For now I suggest either reverting the original patch, or at least not
> >>>>>>> enabling the knob by default for any machine types. In particular, when
> >>>>>>> using MicroVM, the user must leave the knob disabled when direct booting
> >>>>>>> a kernel on OVMF, and the user may or may not enable the knob when
> >>>>>>> direct booting a kernel on SeaBIOS.
> >>>>>>
> >>>>>> Having it opt-in via a knob would defeat Jason's goal of having the seed
> >>>>>> available automatically.
> >>>>>
> >>>>> Yes, adding a knob is absolutely out of the question.
> >>>>>
> >>>>> It also doesn't actually solve the problem: this triggers when QEMU
> >>>>> passes a DTB too. It's not just for the new RNG seed thing. This bug
> >>>>> isn't new.
> >>>>
> >>>> In the other thread I also mentioned that this RNG Seed addition has
> >>>> caused a bug with AMD SEV too, making boot measurement attestation
> >>>> fail because the kernel blob passed to the firmware no longer matches
> >>>> what the tenant expects, due to the injected seed.
> >>>>
> >>>
> >>> I was actually expecting this to be an issue in the
> >>> signing/attestation department as well, and you just confirmed my
> >>> suspicion.
> >>>
> >>> But does this mean that populating the setup_data pointer is out of
> >>> the question altogether? Or only that putting the setup_data linked
> >>> list nodes inside the image is a problem?
> >>
> >> QEMU already has to inject a whole bunch of stuff into confidential
> >> computing guests. The way it's done (IIRC) is that the non-compressed,
> >> trailing part of pflash (basically where the reset vector code lives
> >> too) is populated at OVMF build time with a chain of GUID-ed structures,
> >> and fields of those structures are filled in (at OVMF build time) from
> >> various fixed PCDs. The fixed PCDs in turn are populated from the FD
> >> files, using various MEMFD regions. When QEMU launches the guest, it can
> >> parse the GPAs from the on-disk pflash image (traversing the list of
> >> GUID-ed structs), at which addresses the guest firmware will then expect
> >> the various crypto artifacts to be injected.
> >>
> >> The point is that "who's in control" is reversed. The firmware exposes
> >> (at build time) at what GPAs it can accept data injections, and QEMU
> >> follows that. Of course the firmware ensures that nothing else in the
> >> firmware will try to own those GPAs.
> >>
> >> The only thing that needed to be hard-coded when this feature was
> >> introduced was the "entry point", that is, the flash offset at which
> >> QEMU starts the GUID-ed structure traversal.
> >>
> >> AMD and IBM developers can likely much better describe this mechanism,
> >> as I've not dealt with it in over a year. The QEMU side code is in
> >> "hw/i386/pc_sysfw_ovmf.c".
> >>
> >> We can make setup_data chaining work with OVMF, but the whole chain
> >> should be located in a GPA range that OVMF dictates.
> > 
> > It sounds like what you describe is pretty OVMF-specific though,
> > right?
> 
> Yes, completely OVMF specific.
> 
> > Do we want to tie things together so tightly like that?
> 
> It depends on what the goal is:
> 
> - do we want setup_data chaining work generally?
> 
> - or do we want only the random seed injection to stop crashing OVMF guests?
> 
> In the latter case, we only need to teach QEMU to reliably recognize
> OVMF from the on-disk firmware binary (regardless of pflash use), and
> then not expose any setup_data in guest RAM. The UEFI guest kernel will
> use EFI_RNG_PROTOCOL (when available, from virtio-rng-pci), and no
> particular seed otherwise.
> 
> (This is the "papering over" case, which I don't think is necessarily
> wrong; only it should be robust. I thought pflash would be usable for
> that; turns out it isn't. Thus, we could perhaps try identifying a
> firmware binary as "OVMF" by contents.)
> 
> In the former case though, I think the "tight coupling" is unavoidable.
> As long as setup_data is needed by the kernel extremely early, no
> "firmware hiding" or "firmware independence" is in place yet.
> 
> > Given we only need 48 bytes or so, isn't there a more subtle place we
> > could just throw this in ram that doesn't need such complex
> > coordination?
> 
> These tricks add up and go wrong after a while. The pedantic
> reservations in the firmware have proved necessary.
> 
> IIUC, with v2, the setup_data_base address would (most frequently) be 96
> KB. edk2 does have uses for very low memory. If OVMF's PlatformPei does
> not reserve away the area, UefiCpuPkg or other drivers might allocate an
> overlapping chunk, even if only temporarily. That might not break the
> firmware, but it could overwrite the random seed. If the guest kernel
> somehow consumed that seed (rather than getting one from
> EFI_RNG_PROTOCOL -- what if no virtio-rng-pci device was configured?),
> that could potentially destroy the guest's security, without any
> obvious/immediate signs.

The guest kernel shouldn't load this random seed even if it is
provided by the hypervisor, when running in a confidential
virutalization environment like SEV/TDX or equiv for other arches.
It can't trust the hypervisor to have actually used random data
for populating the seed value. On x86 it would have to rely on
the hardware RDRAND/RDSEED for an initial seed.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

