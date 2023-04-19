Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D006E72C7
	for <lists+linux-efi@lfdr.de>; Wed, 19 Apr 2023 07:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDSF4K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Apr 2023 01:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSF4J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Apr 2023 01:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367583F2
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 22:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681883678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrwcQ1LtG/ywUFl9VgsqvEPGlNpBK1rDtlIAlfMmnew=;
        b=eclPq2OES/1PFXaL76CaUo13kY7N6nNRY4sgBzBx2FlzAGS9AtVuxl/57oqJ9ZEV+Nadsj
        FqKdtWHONaYI9mtbE602TSIqfSZFZA6lshdF3CRW1P53Lj4qIEoW9S6pADO/RVFdHCO8sI
        0B/4vm4MTDQ6d2S3ZFVjNDOwerLx1BA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-pRiaoT1kMi6p4ABgcWtnRg-1; Wed, 19 Apr 2023 01:54:35 -0400
X-MC-Unique: pRiaoT1kMi6p4ABgcWtnRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DFB5293249A;
        Wed, 19 Apr 2023 05:54:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E81C40444C0;
        Wed, 19 Apr 2023 05:54:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 69ABA18009A9; Wed, 19 Apr 2023 07:54:32 +0200 (CEST)
Date:   Wed, 19 Apr 2023 07:54:32 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
Message-ID: <jwvybt4sro56aiqvddn6jxdjpdelasdhl747c25kzv4vbjr7ph@fbtheokrtxce>
References: <20230416120729.2470762-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416120729.2470762-1-ardb@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Apr 16, 2023 at 02:07:26PM +0200, Ard Biesheuvel wrote:
> This series is a proof-of-concept that implements support for the EFI
> zboot decompressor for x86. It replaces the ordinary decompressor, and
> instead, performs the decompression, KASLR randomization and the 4/5
> level paging switch while running in the execution context of EFI.
> 
> This simplifies things substantially, and makes it straight-forward to
> abide by stricter future requirements related to the use of writable and
> executable memory under EFI, which will come into effect on x86 systems
> that are certified as being 'more secure', and ship with an even shinier
> Windows sticker.
> 
> This is an alternative approach to the work being proposed by Evgeny [0]
> that makes rather radical changes to the existing decompressor, which
> has accumulated too many features already, e.g., related to confidential
> compute etc.
> 
> EFI zboot images can be booted in two ways:
> - by EFI firmware, which loads and starts it as an ordinary EFI
>   application, just like the existing EFI stub (with which it shares
>   most of its code);
> - by a non-EFI loader that parses the image header for the compression
>   metadata, and decompresses the image into memory and boots it.

I like the idea to have all EFI archs handle compressed kernels the same
way.

But given that going EFI-only on x86 isn't a realistic option for
distros today this isn't really an alternative for Evgeny's patch
series, we have to fix the existing bzImage decompressor too.

> Realistically, the second option is unlikely to ever be used on x86,

What would be needed to do so?  Teach kexec-tools and grub2 parse and
load zboot kernels I guess?

take care,
  Gerd

