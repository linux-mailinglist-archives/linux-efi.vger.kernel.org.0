Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E84D6B1F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfJNVSf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 17:18:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbfJNVSf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Oct 2019 17:18:35 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00BA01EC0C31;
        Mon, 14 Oct 2019 23:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571087913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lJDIS6qAo6rnwlSCT9/pbXVO7qJtsNwnZrYxxlfr9S4=;
        b=J0FjW/tGdfErf5SSe4pHEpVZ0cPl22tHByaKRtdroYDaim+Z4f4i0OG2FVLwpvpp67Y+EC
        lJEkYbrpqpqTUNWnYf8JHpBpmOja0+SLZeMvrsxC/GcTY9lJKXVo8GxVPd1d6DID2SYbFf
        a1mIpKcPwyEZKUVsSzPSjRcWn7aIWw4=
Date:   Mon, 14 Oct 2019 23:18:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] x86, efi: never relocate kernel below lowest
 acceptable address
Message-ID: <20191014211825.GJ4715@zn.tnic>
References: <20191012034421.25027-1-kasong@redhat.com>
 <20191014101419.GA4715@zn.tnic>
 <20191014202111.GP15552@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191014202111.GP15552@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 11:21:11PM +0300, Jarkko Sakkinen wrote:
> Was there a section in the patch submission documentation to point out
> when people send patches with all the possible twists for an acronym?

I don't think so.

> This is giving me constantly gray hairs with TPM patches.

Well, I'm slowly getting tired of repeating the same crap over and over
again about how important it is to document one's changes and to write
good commit messages. The most repeated answers I'm simply putting into
canned reply templates because, well, saying it once or twice is not
enough anymore. :-\

And yeah, I see your pain. Same here, actually.

In the acronym case, I'd probably add a regex to my patch massaging
script and convert those typos automatically and be done with it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
