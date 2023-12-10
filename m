Return-Path: <linux-efi+bounces-159-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B2E80B9AA
	for <lists+linux-efi@lfdr.de>; Sun, 10 Dec 2023 08:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39F1B20A5B
	for <lists+linux-efi@lfdr.de>; Sun, 10 Dec 2023 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568725235;
	Sun, 10 Dec 2023 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQj5Mxqp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF7BD;
	Sat,  9 Dec 2023 23:30:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2880709a12.1;
        Sat, 09 Dec 2023 23:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702193414; x=1702798214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJZ68NEWh29H4sGqzC2fIlY8OiY/jserKoz9/XMRFts=;
        b=YQj5MxqpFmS3F4wAUDUkndAhFQvwmEhEN4RBTWS5eFoLHQO/vKcpKDrrwo8mE9xAHH
         5CcU4J0AXUbt5bTOkJXpReIw4fAg8b0wD6h8IGL5voq2ny53uxWJzMCmsKc+9bicUXZ0
         QinC7tfuubQDwykKlxvUU5gmXl9cwHCBT/gCwu6atH8zbn8Tfcf9UGaqlvped8hpPwfr
         SossnzV3V1MdkcpzgHjnV0vCBEiVvJYErXpVC4q5EvMolzWEkknOTf3UTNmyBsx6WF5u
         /bRXbZ2iXOq9GBUgqsMEt3pwhy9y3BhUNn8m9Cgt4Imns6FO3nkcy7TVtjUfjFHykrds
         Jetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702193414; x=1702798214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJZ68NEWh29H4sGqzC2fIlY8OiY/jserKoz9/XMRFts=;
        b=H6csmPLg26ij78VGkHl5Wzzgra+pNPjl4hrPffqOUlf+NTQAIK5hYHivQ1uneREpdP
         uuIfDiMkO68DfzB2IwunWZL7RtCMpbhAXGSj2fLAChi0uGqXpe3iUB+QxLXr1K3BKLkN
         9WljgCadWifRLtqDEHbAnoJ/9kdcaR+AX1elznaIGSz7imcb1r40rJ92bPDKH5gvR7Jf
         v8vn/eR+Oza38kr9KmSBQKn4jdsv2CDpFMcR5wXKojrt+cg2syEpNUy/E0zj5f+0Y1pS
         klIfxP0hSj4e1eFLKRFm4BxVwv5p2XFBS9A/BibTwasufliOwuBAHbtD/TdkvOdbYG/B
         oG2g==
X-Gm-Message-State: AOJu0YyyGXuG3ntcGB7q41lMGOUte906GEh9SuoVUpjoKl+kN3cXsyl6
	sssLmg8dYN3Ts9ucFgBLHwQ=
X-Google-Smtp-Source: AGHT+IE4E/haG2aufMTkcvK3NaUCG+up+gPhQuwhMTIAchkganZEWSFvdmizSOzYzpS7+oaJliX8vg==
X-Received: by 2002:a17:902:f686:b0:1cf:cf34:d4fa with SMTP id l6-20020a170902f68600b001cfcf34d4famr2556606plg.28.1702193414038;
        Sat, 09 Dec 2023 23:30:14 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id hx11-20020a17090b440b00b002886e13bcbesm6075884pjb.56.2023.12.09.23.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 23:30:13 -0800 (PST)
Message-ID: <7cf21703-391a-4123-b862-14a1af62aeaa@gmail.com>
Date: Sun, 10 Dec 2023 14:30:08 +0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel 6.6.1 hangs on "loading initial ramdisk"
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: bwg <whirl@mniotilta.ca>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, shibedrill1@gmail.com
References: <9057d7de-f2e0-44ba-bec7-8b0861b2a850@gmail.com>
 <ZXVdZE3D-KFBqPnj@archie.me>
 <fe7a2b72-9418-42dc-b6fb-2aa93bc4eabc@leemhuis.info>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <fe7a2b72-9418-42dc-b6fb-2aa93bc4eabc@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/23 14:15, Linux regression tracking (Thorsten Leemhuis) wrote:
> [Moved a lot of people CCed in the previous mail to BCC, as I'm pretty
> sure they do not care about this regression; at the same time add the
> x86 maintainers and the efi list.]
> 
> [Top posting for once to make this easier accessible for everyone.]
> 
> Ard, Boris, just to make it obvious: the regression report quoted below
>  was bisected to a1b87d54f4e45f ("x86/efistub: Avoid legacy decompressor
> when doing EFI boot") [v6.6-rc1] from Ard which committed by Boris.
> There are two users that seem to be affected by this. Both seem to run
> Arch. For details see:
> https://bugzilla.kernel.org/show_bug.cgi?id=218173
> 
> Bagas, FWIW, I know you want to help, but your previous mail is not
> helpful at all -- on the contrary, as it is yet another one that is
> likely hurting my regression tracking efforts[1]. Please stop and just
> tell me about things like this in a private mail, as we agreed on earlier.
> 
> Ciao, Thorsten
> 
> [1] This is why: You just added Ard and Boris to the CC, but did not
> make it obvious *why* they should care about that mail. They (and all
> the other recipients) for sure will have no idea what a1b87d54f4e45f
> exactly is, so you should have mentioned the commit summary. And doing
> that after a big quote makes it worse, as many people now need to scroll
> down to see if that mails contains something that might be relevant for
> them -- and just a waste of time if not.
> 
> Furthermore, sending the first mail of the thread to all those people
> and lists was likely not very wise, as nobody is likely to care in a
> case like this. And not removing all those people and lists in the
> second mail of the thread make it a lot worse, as it became clear that
> many people and list do not care about it now that the regression was
> bisected. Hence it's best to remove them, we all get enough mail already.
> 
> All that makes people ignore mails from you -- and maybe about
> regression tracking in general. :-(
> 

Oops, I didn't greet additional Cc's as you mentioned (that's my
tendency when handling regressions).

So maybe we continue tracking this on Bugzilla or keeping on ML or
both?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


