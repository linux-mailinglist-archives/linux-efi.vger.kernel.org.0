Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8944EB3AD
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiC2StF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiC2StE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 14:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CE1D1A6E4A
        for <linux-efi@vger.kernel.org>; Tue, 29 Mar 2022 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648579639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F+hFNVkkgjGz9IaZzNaUdch/kgipd5Sk9YhwiWCqBjg=;
        b=Msh8EMXtuY0uaSPZlxW5PCPfOfg9fHgYi+Fx431JmQc/m3VOlldUdCd+QzhxcH7rFVRx3Q
        W4cOiA6b/tlHbVxv5NOJ9N0lJeDGlARrk/KJUbEqvHSbeK8l5hMhiVZz/LpL9e+4jIyEAG
        IuJMT0KlyZRFY/s/v3yIqsAFpfsKtf0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-18P0M4RXObKXdj1XMiX7ag-1; Tue, 29 Mar 2022 14:47:15 -0400
X-MC-Unique: 18P0M4RXObKXdj1XMiX7ag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFCFC91BD81;
        Tue, 29 Mar 2022 18:47:14 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DD84401E2A;
        Tue, 29 Mar 2022 18:47:14 +0000 (UTC)
Date:   Tue, 29 Mar 2022 14:47:12 -0400
From:   Peter Jones <pjones@redhat.com>
To:     baskov@ispras.ru
Cc:     ardb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
Message-ID: <20220329184712.vl7jzq23h5m5kvqh@redhat.com>
References: <20220224154330.26564-1-baskov@ispras.ru>
 <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
 <20220228183044.GA18400@srcf.ucam.org>
 <9787f1c1948cc640e70a50e4b929f44f@ispras.ru>
 <20220303204759.GA20294@srcf.ucam.org>
 <20220318163739.5doimyda5e3kdcef@redhat.com>
 <20e2f5b9ab008b12f14e763127f5ca1b@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20e2f5b9ab008b12f14e763127f5ca1b@ispras.ru>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 24, 2022 at 07:39:47PM +0300, baskov@ispras.ru wrote:
> On 2022-03-18 19:37, Peter Jones wrote:
> > On Thu, Mar 03, 2022 at 08:47:59PM +0000, Matthew Garrett wrote:
> > > On Thu, Mar 03, 2022 at 04:42:07PM +0300, baskov@ispras.ru wrote:
> > > > On 2022-02-28 21:30, Matthew Garrett wrote:
> > > > > On Mon, Feb 28, 2022 at 05:45:53PM +0100, Ard Biesheuvel wrote:
> > > > >
> > > > > > Given that this is a workaround for a very specific issue arising on
> > > > > > PI based implementations of UEFI, I consider this a quirk, and so I
> > > > > > think this approach is reasonable. I'd still like to gate it on some
> > > > > > kind of identification, though - perhaps something related to DMI like
> > > > > > the x86 core kernel does as well.
> > > > >
> > > > > When the V1 patches were reviewed, you suggested allocating
> > > > > EFI_LOADER_CODE rather than EFI_LOADER_DATA. The example given for a
> > > > > failure case is when NxMemoryProtectionPolicy is set to 0x7fd4, in which
> > > > > case EFI_LOADER_CODE, EFI_BOOT_SERVICES_CODE and
> > > > > EFI_RUNTIEM_SERVICES_CODE should not have the nx policy applied. So it
> > > > > seems like your initial suggestion (s/LOADER_DATA/LOADER_CODE/) should
> > > > > have worked, even if there was disagreement about whether the spec
> > > > > required it to. Is this firmware applying a stricter policy?
> > > >
> > > > Yes, this firmware is being modified to enforce stricter policy.
> > > 
> > > Ok. I think this should really go through the UEFI spec process - I
> > > agree that from a strict interpretation of the spec, what this
> > > firmware
> > > is doing is legitimate, but I don't like having a situation where we
> > > have to depend on the DXE spec.
> > 
> > It's in the process of getting into the UEFI spec now as
> > https://bugzilla.tianocore.org/show_bug.cgi?id=3519 .
> > 
> > > How does Windows handle this? Just update the page tables itself for
> > > any
> > > regions it needs during boot?
> > 
> > Microsoft's bootloader sets up its own pagetables, though I believe
> > they're switching it to use the (soon to be) standardized API.
> 
> The third version of the patch is the most close in structure
> to the proposed protocol. And until the protocol is standardized and
> implemented on problematic firmware, I think, it remains the better
> solution in terms of simplicity and further porting to the new
> protocol.

The ECR was approved at last week's meeting, it'll be in the next UEFI
spec.  Details of what spec version that'll be and when it will
officially be released are still under discussion, but it's been
approved in its current form.  Microsoft has been kind enough to provide
us code for test firmware, though the build process is a little rough.

I've done some builds of it here: https://copr.fedorainfracloud.org/coprs/pjones/mu-qemuq35/builds/ .
The src rpm there is a bit absurdly large, because I've done the very
quick-and-dirty hack of just shoving a pile of git repos into it instead
of trying to make release tarballs of everything, and it needs the
network enabled to rebuild it for fairly dumb reasons.  But the result
is a firmware that works in QEMU.

> It is desirable to get the issue resolved, and make the kernel stricter
> comply to the spec, without waiting for the new API implementation.
> And later, switch the kernel to be using the protocol with
> subsequent patches as soon as it gets usable.

It works for the bootloaders in my development trees; I've booted a
kernel with your patches.  From the bootloader POV we do need one more
simple patch to enable the compatibility flag in the headers, I'll send
it as a follow-up to this mail.

-- 
        Peter

