Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4558612DC32
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 23:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLaWvh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 17:51:37 -0500
Received: from cavan.codon.org.uk ([93.93.128.6]:51798 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfLaWvh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 17:51:37 -0500
X-Greylist: delayed 1372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Dec 2019 17:51:36 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XKOHTo6zu2DfekeXpI2v+Dec+QqJwXCPmaBxyuFPC/8=; b=udZOn1AuqL9LkDFm3v1QhVmkS
        QGabZ01W1wplNbrtmr1BOmdsQm0BcR2YbQc8mw2TuQ7f7qNr7r2kSgHrdTHiVwF3AoELX5q9z4ptl
        cagxaIN7/BxkWjhfbw7vEwjPlinTNYryMumox5bGe3BUdNVeCJw6z52AQnaIoL4LqImHI=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1imQ0D-0003lT-Fx; Tue, 31 Dec 2019 22:28:37 +0000
Date:   Tue, 31 Dec 2019 22:28:37 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [RFC PATCH] efi/x86: limit EFI old memory map to SGI UV1 machines
Message-ID: <20191231222837.wpardrndvnukpgfp@srcf.ucam.org>
References: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20191231160547.GB13549@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231160547.GB13549@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 31, 2019 at 05:05:47PM +0100, Borislav Petkov wrote:

> looks like mfleming meant the opposite: some apple laptops don't like
> the 1:1 runtime mapping. But there might be more and I believe mjg59 had
> some use case at the time but I could be remembering it wrong.

I've lost most of the context for this over the years, I'm afraid. The 
case I remember was that the EFI reboot code on some hardware would 
attempt to access physical addresses and we wanted some form of 1:1 
mapping to handle that, but I really don't remember what the larger 
details were.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
