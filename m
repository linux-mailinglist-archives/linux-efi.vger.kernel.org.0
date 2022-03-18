Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C84DDF2A
	for <lists+linux-efi@lfdr.de>; Fri, 18 Mar 2022 17:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiCRQjI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Mar 2022 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbiCRQjI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Mar 2022 12:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 170A1261DCC
        for <linux-efi@vger.kernel.org>; Fri, 18 Mar 2022 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647621468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRkiLeX8mpI9J41/mUB+vM+WzcbOp3+T8YuiOA6u2xg=;
        b=gHWPXAwVTz98yGXfgTVE+qJUT5uX0p8DRL9B3q0Tn5FmmKE6T2M/S5ckL/7L3d303Rulbr
        zXTyPhk4Z4d0Y6Mo/b5QjqslffUIqJsEmJlWufocKgpQrwIS3dHpwNlzg/kqtgnC0QNQLg
        OuI+DYnTRz/Uk6Eey+wY0rqzWvnxeuc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-3qS8c0tTNciD3sX1MAK73g-1; Fri, 18 Mar 2022 12:37:42 -0400
X-MC-Unique: 3qS8c0tTNciD3sX1MAK73g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56BF618A0160;
        Fri, 18 Mar 2022 16:37:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48A5535422;
        Fri, 18 Mar 2022 16:37:41 +0000 (UTC)
Date:   Fri, 18 Mar 2022 12:37:39 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     baskov@ispras.ru, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
Message-ID: <20220318163739.5doimyda5e3kdcef@redhat.com>
References: <20220224154330.26564-1-baskov@ispras.ru>
 <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
 <20220228183044.GA18400@srcf.ucam.org>
 <9787f1c1948cc640e70a50e4b929f44f@ispras.ru>
 <20220303204759.GA20294@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303204759.GA20294@srcf.ucam.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 03, 2022 at 08:47:59PM +0000, Matthew Garrett wrote:
> On Thu, Mar 03, 2022 at 04:42:07PM +0300, baskov@ispras.ru wrote:
> > On 2022-02-28 21:30, Matthew Garrett wrote:
> > > On Mon, Feb 28, 2022 at 05:45:53PM +0100, Ard Biesheuvel wrote:
> > > 
> > > > Given that this is a workaround for a very specific issue arising on
> > > > PI based implementations of UEFI, I consider this a quirk, and so I
> > > > think this approach is reasonable. I'd still like to gate it on some
> > > > kind of identification, though - perhaps something related to DMI like
> > > > the x86 core kernel does as well.
> > > 
> > > When the V1 patches were reviewed, you suggested allocating
> > > EFI_LOADER_CODE rather than EFI_LOADER_DATA. The example given for a
> > > failure case is when NxMemoryProtectionPolicy is set to 0x7fd4, in which
> > > case EFI_LOADER_CODE, EFI_BOOT_SERVICES_CODE and
> > > EFI_RUNTIEM_SERVICES_CODE should not have the nx policy applied. So it
> > > seems like your initial suggestion (s/LOADER_DATA/LOADER_CODE/) should
> > > have worked, even if there was disagreement about whether the spec
> > > required it to. Is this firmware applying a stricter policy?
> > 
> > Yes, this firmware is being modified to enforce stricter policy.
> 
> Ok. I think this should really go through the UEFI spec process - I 
> agree that from a strict interpretation of the spec, what this firmware 
> is doing is legitimate, but I don't like having a situation where we 
> have to depend on the DXE spec.

It's in the process of getting into the UEFI spec now as
https://bugzilla.tianocore.org/show_bug.cgi?id=3519 .

> How does Windows handle this? Just update the page tables itself for any 
> regions it needs during boot?

Microsoft's bootloader sets up its own pagetables, though I believe
they're switching it to use the (soon to be) standardized API.

-- 
        Peter

