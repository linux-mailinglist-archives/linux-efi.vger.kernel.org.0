Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70218144C4B
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2020 08:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAVHDZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Jan 2020 02:03:25 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36703 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgAVHDZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Jan 2020 02:03:25 -0500
Received: by mail-wm1-f46.google.com with SMTP id p17so5961249wma.1;
        Tue, 21 Jan 2020 23:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ab8hJ1KeheMaGSW8LVKUq2Wv2SddgDk/lLa9lpwNWPA=;
        b=EutpUhWuaEf89kxILSkERgEXgkg7ANVsBPLtE0vXFRVmafV0C45sC8BU3wAbZ+M0Jb
         hjLjGajmB0Tjk986GPzhQHzQJrTZxh4F5+dy4e0jyTz3PR9s8y1Gh21+t6gCblK2mFQw
         2vOMcm5Ujd9P/qaVbjgSGT5FHKviVIJOd2Ws0Dn7X9PG+03jaxt/RjDOCXn02FyJWkcG
         Z0HGPYazsx5pC2MFdVosd7WSdRdbGYLBiUo0BezweC89OuzE5frJBzupfHD8Mt1xhiaF
         58uOtZOc6vYP5DUCn1A09wFcZddj1Nkix22eyE9Uwe2nRsVAWjvHdKsAW++O2V8JwsZG
         +4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ab8hJ1KeheMaGSW8LVKUq2Wv2SddgDk/lLa9lpwNWPA=;
        b=YZ66tuFpFuxERDmnxBwebdR3rA0TnrD8nqvW3GZ4h6PTjw2l7qTgMPjJlCO/dL4uXI
         tP6E5gkyxCr7fPEZAYE7tjWTFIroWqh/ZDrx0JBv1ioSR37GtOfTuQgqEfNRiZlsR9fJ
         JBK98o4scRLgXaw9hUCKPNTAyzkgMYoNxvbZJR24M9KYS7j+6Nb92C7F4TT+DFfbso/u
         6m8/yjr1xL9/GBP8N9HUm4USniJaemouPk6VHPC+NTIhOLvDUpyAh0BxFRpwbr7TQzQh
         941PQlaGAdSxH9pfR7iZnisnYGK4/NSp4v5qBzKorL0/ZphWqSs9TuL+0IuEIqJxEaQC
         i+2Q==
X-Gm-Message-State: APjAAAX76gNBWkZZ4ZhKXdly83okDQBz5IV1nwvhaIhLoZlWwbnbzju1
        lrFjJI9eD+k1nfdNMTI9naVpyrAR
X-Google-Smtp-Source: APXvYqyz1r2v7hniCa7+TNQd/FZJXCSm3kT2arR0JDIqUURCXMX0AoZFfxvyPwRZZjI8n6RqcythiA==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr1295113wmq.65.1579676603231;
        Tue, 21 Jan 2020 23:03:23 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i5sm2640503wml.31.2020.01.21.23.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 23:03:22 -0800 (PST)
Date:   Wed, 22 Jan 2020 08:03:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL 00/13] More EFI updates for v5.6
Message-ID: <20200122070320.GB100954@gmail.com>
References: <20200113172245.27925-1-ardb@kernel.org>
 <20200120082501.GC26606@gmail.com>
 <CAKv+Gu_wZsFwWtM85uuHEZAk7SEWyfFCss4DQYOn+J2vuzGC2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_wZsFwWtM85uuHEZAk7SEWyfFCss4DQYOn+J2vuzGC2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > Thanks Ard, I've applied these and the 3 fixes in the second series to
> > tip:efi/core. It all merged nicely and looks good here. Let me know if
> > there's anything amiss.
> 
> Thanks Ingo,
> 
> Apart from the mismatched parens in the commit log of the top commit,
> everything looks fine.

Indeed - and since it was the top commit I amended it, and while at it I 
fixed not just the parenthesis error I introduced, but added the right 
SHA1 as well:

    efi/x86: Disallow efi=old_map in mixed mode
    
    Before:
    
      1f299fad1e31: ("efi/x86: Limit EFI old memory map to SGI UV machines")
    
    enabling the old EFI memory map on mixed mode systems
    disabled EFI runtime services altogether.

> It does appear that the KASAN fix is not 100% sufficient for mixed 
> mode, so I'll need to apply another fix on top there, but we may have 
> other things to fix during the cycle so I'll leave that for later.

Sounds good!

Thanks,

	Ingo
