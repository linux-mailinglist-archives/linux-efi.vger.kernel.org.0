Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5906F89C2
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjEETrJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 15:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjEETrI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 15:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D8DE0;
        Fri,  5 May 2023 12:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40EC160DBE;
        Fri,  5 May 2023 19:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD1EC433EF;
        Fri,  5 May 2023 19:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683316026;
        bh=Sb2KgQ5DsUgQ8xKWmkYNMl26e38BQYOVMpl/Vac7Mlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elsCHSqNwFxUfu6VDPA5BgwMa9uPCAgvGK/9pAW2TU5GB9bI3Ll6zAfgwLZ0x/r5R
         IluW+zvNltdv9tF/cWmtu/jBRAAqCK5t2m8FHh2N6sAIIyhxca/kBfj26fVEeoWd2L
         A2r85aEVAIz5tUkrO73+HjZlYFK2Hmh7eFe7uuLwvJg4PXMsc+efjVhtqEnrcUOG3P
         ULB+CdNJnc7D3UqmB9EY104YZbopRSB4H5PLwfM4gBQWbRTiDjSNdEafQuGCZngOO3
         ZJ/Sv/PL7t1UG3pd7QfV1iPUyhYqUn3e6R7gLh6KK4sIutQOZ+ihxN1XWeAU8Hc+Y7
         F5IdlWXYgma6Q==
Date:   Fri, 5 May 2023 21:46:56 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Message-ID: <ZFVdMJIQ+4BmXvhN@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <ZFVBLCLVK7AAStst@kernel.org>
 <81ce947c-07a0-0975-1d09-776fb03c64b9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ce947c-07a0-0975-1d09-776fb03c64b9@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 05, 2023 at 02:58:28PM -0400, Ross Philipson wrote:
> On 5/5/23 13:47, Simon Horman wrote:
> > On Thu, May 04, 2023 at 02:50:16PM +0000, Ross Philipson wrote:

...

> > > +asmlinkage __visible void sl_check_region(void *base, u32 size)
> > > +{
> > > +	sl_check_pmr_coverage(base, size, false);
> > > +}
> > 
> > I'm a nit unsure, what to do here, but clang-16 with W=1 says the following.
> > 
> > arch/x86/boot/compressed/sl_main.c:533:27: warning: no previous prototype for function 'sl_main' [-Wmissing-prototypes]
> > asmlinkage __visible void sl_main(void *bootparams)
> >                            ^
> > arch/x86/boot/compressed/sl_main.c:533:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > asmlinkage __visible void sl_main(void *bootparams)
> >                       ^
> >                       static
> 
> Yea we will have to look into why this is. This function is only ever called
> from asm code so that might have something to do with this.

Thanks.

...

> > > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > > index 01d19fc..74e3e7df 100644
> > > --- a/arch/x86/include/uapi/asm/bootparam.h
> > > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > > @@ -26,6 +26,7 @@
> > >   /* loadflags */
> > >   #define LOADED_HIGH	(1<<0)
> > >   #define KASLR_FLAG	(1<<1)
> > > +#define SLAUNCH_FLAG	(1<<2)
> > >   #define QUIET_FLAG	(1<<5)
> > >   #define KEEP_SEGMENTS	(1<<6)
> > >   #define CAN_USE_HEAP	(1<<7)
> > 
> > nit: please consider using BIT()
> 
> I am a little reluctant to change something like this in an existing header.
> It seems a bit out of scope for the patch set.

Yes, sorry for the noise on this one.
I agree that what you have is the best approach here.
