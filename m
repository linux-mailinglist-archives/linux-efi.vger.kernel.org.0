Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40671377CE
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfFFP0Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 11:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbfFFP0Y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Jun 2019 11:26:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 193E520684;
        Thu,  6 Jun 2019 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559834783;
        bh=CnpmLwWMUfvuC9/eV2CK/I+uHdWA+4YlKpQiP0MdZlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yg0Ix0oT9Que8XZMfvq/mQQjISrFjiOvS/n/eajzsAEMZDSkAJn/cnbcJmzmEqCaY
         h06t4rRqGCwvjr0eHk6a8Io4q0Dq92GlpBFYeuLNuhDRaz+ALjBMzKlZg61bjM9mig
         vFAIaaziY+LBW+VbW4z1liEyei/OXkmYPTSYptMg=
Date:   Thu, 6 Jun 2019 17:26:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     eb@emlix.com, linux-efi@vger.kernel.org, stable@vger.kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH for-4.9-stable] efi/libstub: Unify command line param
 parsing
Message-ID: <20190606152621.GA21921@kroah.com>
References: <20190606102513.16321-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606102513.16321-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 06, 2019 at 12:25:13PM +0200, Ard Biesheuvel wrote:
> Commit 60f38de7a8d4e816100ceafd1b382df52527bd50 upstream.
> 
> Merge the parsing of the command line carried out in arm-stub.c with
> the handling in efi_parse_options(). Note that this also fixes the
> missing handling of CONFIG_CMDLINE_FORCE=y, in which case the builtin
> command line should supersede the one passed by the firmware.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: bhe@redhat.com
> Cc: bhsharma@redhat.com
> Cc: bp@alien8.de
> Cc: eugene@hp.com
> Cc: evgeny.kalugin@intel.com
> Cc: jhugo@codeaurora.org
> Cc: leif.lindholm@linaro.org
> Cc: linux-efi@vger.kernel.org
> Cc: mark.rutland@arm.com
> Cc: roy.franz@cavium.com
> Cc: rruigrok@codeaurora.org
> Link: http://lkml.kernel.org/r/20170404160910.28115-1-ard.biesheuvel@linaro.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> [ardb: fix up merge conflicts with 4.9.180]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> This fixes the GCC build issue reported by Eike.
> 
> Note that testing of arm64 stable kernels should cover CONFIG_RANDOMIZE_BASE,
> since it has a profound impact on how the kernel binary gets put together.

Good idea.  Is that in any arm64 stable kernel configuration?  If not, I
can ask the Linaro build/test people to add it there.

And isn't it part of kernel.ci already?  We get the results of that for
stable releases.

Anyway, thanks for the patch, now queued up.

thanks,

greg k-h
