Return-Path: <linux-efi+bounces-645-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A33A85F839
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 13:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C69C2878F7
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815864CCB;
	Thu, 22 Feb 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="nQhAYbvy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAD633FE
	for <linux-efi@vger.kernel.org>; Thu, 22 Feb 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605055; cv=none; b=o4OFhVaAaRZugOnjEPmnjlXTzkm1lpV7p4XQQCK+V3Re+Nf/0QEOcINBOGqss1FWUwvYMJg4bGxRcWnIwxLNUSyODl/wFb10fmCZ/WRDTjOctHtadRCIANBSXpV1OTW3F3UQVUhozAv982auk7GNr4Km/7SxULRpGc65H3itkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605055; c=relaxed/simple;
	bh=MrBNqlbyxP3DrROkVXIP046XgIKyGSNJYrmBX+jdlDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyePn9c2qYiS89AeWSVZBNVroRA8gdpk0OW5EDYYi0NRBbrQ9M28TDIgH5UvI7jv57HnMZPgKJ+/wdBPhAirHkllyiBHTH3+MLAiG/Iquv4kkG8U/4Oaky74vbLNOswrRWYEi2kBBS4TxXpinqDk6o+bQxf4NTul6Qm8LdB3qbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=nQhAYbvy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563ed3d221aso1532531a12.0
        for <linux-efi@vger.kernel.org>; Thu, 22 Feb 2024 04:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708605052; x=1709209852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtMJTU0KaK69D2gKtHaxXyryfBE+awWVy+sf0VRiX1M=;
        b=nQhAYbvyMssdQPiXRiaCoqsyDuAiAs1fFodFrXH7ciLuQDsjQSV0nv5XMpFbHhzT9K
         d0NRw7Z2AU0dOTm+eufwjNq9yaM1vvSHSl5WSy1RvQ9eMj/le1LMxvRd/POnEbeIOQKb
         lxVpeoe+AOzKxfaJNaffihJBUAHUUZ5FXrQtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708605052; x=1709209852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtMJTU0KaK69D2gKtHaxXyryfBE+awWVy+sf0VRiX1M=;
        b=MCtIx27B/3uJSbyvVbQjz9UCPiyLGBIWkF0SAsV0rqfmIBPctVc1ov8BToA/N+UsW9
         f/R8BTqz8E7hz7FT4cm+hHCpvHV6nQv91RaXTEtSjjBsm8BSWAEzQs6FJa0MkUjLqYSY
         3Y5l/ireZxhaWPbUcMDLv4b43Kigaz7UIs7KiOsQSq2/4rexel721ncT9UjN3ZSmXs5Z
         P/XLkFB6kK3NfZDZIfBnQG6IFGdt7V8uqvr/0rg9Kwj5tr6wCorXnehIM5Uh2Ey5zlZv
         KkzuxU3X/kB3q7bXmbqistVZVzSQhat7k5GjH3sjlV67+19OSZjdzNZxTCqlgKsiuBlr
         SuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9vYTELDJhBoONS86bFA6u8SQi9VWfMqzNiWdLc2DoAM1v1gvQ8cl8gr1Gsrg5Z6RI3NjFDwF095H0td0Sd80Ym97zl4UOLyXY
X-Gm-Message-State: AOJu0YyNLspxjwA6uPLGP0IVzXAG3fdfAHOqW7ug9/plT/f6PZoFrCJa
	utex6vLRzTFXmi4OYgIKFqikW3jN6HWhkSjVaO60r5GCYl37yYwpa0WEymYXMcc=
X-Google-Smtp-Source: AGHT+IFPuQzpowOl3k/GPdUR9TfMIP5AhN9fSjb+vcvG0GakAp/U3UXOgAHES4kjT6cIQFre3AyF/w==
X-Received: by 2002:a17:906:2b0e:b0:a3e:8bd8:b711 with SMTP id a14-20020a1709062b0e00b00a3e8bd8b711mr1842289ejg.37.1708605052106;
        Thu, 22 Feb 2024 04:30:52 -0800 (PST)
Received: from [10.80.67.149] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170907160400b00a3e45fa1c77sm5071178ejd.55.2024.02.22.04.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 04:30:51 -0800 (PST)
Message-ID: <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
Date: Thu, 22 Feb 2024 12:30:50 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
 Eric Biggers <ebiggers@kernel.org>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 9:34 am, Ard Biesheuvel wrote:
> On Thu, 22 Feb 2024 at 04:05, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 15/02/2024 8:17 am, Ard Biesheuvel wrote:
>>> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>>>
>>>> The SHA algorithms are necessary to measure configuration information into
>>>> the TPM as early as possible before using the values. This implementation
>>>> uses the established approach of #including the SHA libraries directly in
>>>> the code since the compressed kernel is not uncompressed at this point.
>>>>
>>>> The SHA code here has its origins in the code from the main kernel:
>>>>
>>>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>>>
>>>> A modified version of this code was introduced to the lib/crypto/sha1.c
>>>> to bring it in line with the sha256 code and allow it to be pulled into the
>>>> setup kernel in the same manner as sha256 is.
>>>>
>>>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>> We have had some discussions about this, and you really need to
>>> capture the justification in the commit log for introducing new code
>>> that implements an obsolete and broken hashing algorithm.
>>>
>>> SHA-1 is broken and should no longer be used for anything. Introducing
>>> new support for a highly complex boot security feature, and then
>>> relying on SHA-1 in the implementation makes this whole effort seem
>>> almost futile, *unless* you provide some rock solid reasons here why
>>> this is still safe.
>>>
>>> If the upshot would be that some people are stuck with SHA-1 so they
>>> won't be able to use this feature, then I'm not convinced we should
>>> obsess over that.
>> To be absolutely crystal clear here.
>>
>> The choice of hash algorithm(s) are determined by the OEM and the
>> platform, not by Linux.
>>
>> Failing to (at least) cap a PCR in a bank which the OEM/platform left
>> active is a security vulnerability.  It permits the unsealing of secrets
>> if an attacker can replay a good set of measurements into an unused bank.
>>
>> The only way to get rid of the requirement for SHA-1 here is to lobby
>> the IHVs/OEMs, or perhaps the TCG, to produce/spec a platform where the
>> SHA-1 banks can be disabled.  There are no known such platforms in the
>> market today, to the best of our knowledge.
>>
> OK, so mainline Linux does not support secure launch at all today. At
> this point, we need to decide whether or not tomorrow's mainline Linux
> will support secure launch with SHA1 or without, right?

I'd argue that's a slightly unfair characterisation.

We want tomorrow's mainline to support Secure Launch.  What that entails
under the hood is largely outside of the control of the end user.

> And the point you are making here is that we need SHA-1 not only to a)
> support systems that are on TPM 1.2 and support nothing else, but also
> to b) ensure that crypto agile TPM 2.0 with both SHA-1 and SHA-256
> enabled can be supported in a safe manner, which would involve
> measuring some terminating event into the SHA-1 PCRs to ensure they
> are not left in a dangling state that might allow an adversary to
> trick the TPM into unsealing a secret that it shouldn't.

Yes.  Also c) because if the end user wants to use SHA-1, they should be
able to.

> So can we support b) without a), and if so, does measuring an
> arbitrary dummy event into a PCR that is only meant to keep sealed
> forever really require a SHA-1 implementation, or could we just use an
> arbitrary (not even random) sequence of 160 bits and use that instead?

a) and b) are in principle independent, but we cannot support b) without
SHA-1.

To cap a PCR, the event log still needs to be kept accurate, and that's
at least one SHA-1 calculation.  If you were to simply extend a dummy
value, the system hopefully fails safe, but the user gets "something
went wrong, you're on your own", rather than "we intentionally blocked
the use of SHA-1, everything is good".

And frankly, you need SHA-1 just to read the event log, if any component
(including TXT itself) wrote a SHA-1 entry into it.


To be blunt.  SHA-1 support is not viably optional today as far as
Secure Launch is concerned.  If there's a suitable Kconfig symbol to use
for people who want a completely SHA-1-less kernel, then we can make
Secure Launch depend on that until such time as the hardware ecosystem
has caught up.

~Andrew

