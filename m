Return-Path: <linux-efi+bounces-3414-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18041A97459
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 20:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60F73AD983
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567552980B0;
	Tue, 22 Apr 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MR39QwKd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26A2980D6
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345868; cv=none; b=IAZ6A9ZlWWQPfKAo6OfFrHQaXa7uobcR1RHri2CQlxPmenCmKswMs5nPwpTZUbl0J+IEjUWNvJ4L/Axsb7KCNIUaUpYoOnRx7SQYEV/NcLMEVioIzgI2puIEpA/p+1lEAlFKF6VtjIhgWSsZNzEDB1kkJ7CTswRQFb4yxq4kA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345868; c=relaxed/simple;
	bh=IdFsdaUTDRdghsX8VxeZ/2CwFZKCgCoBXb6SP0DHe8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+ZBLGm7rHCkk0pbajA0rNsI5v8IxY7Aq0HDaOZk3lB+odoK+JOtVk7sgSf+GDn0SFuQV5o7TCv0P5jzv1ODTpa1ee6WWk5LTZQPoM1AaO3fpQbR6ee4JZl1coyEM2pKlhGA3q4wt4Ej/ISWrQdBVc8f/IzJnR8UhT2E8lnmIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=MR39QwKd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso60669905e9.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1745345865; x=1745950665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IdFsdaUTDRdghsX8VxeZ/2CwFZKCgCoBXb6SP0DHe8w=;
        b=MR39QwKdTZf97qUao1OOktR4IOOeezi9QcWxba8PDqj58jDSlESHAdFOIinEPlDxKb
         64yGwcf4wcOdweJxyTsTaqU28ZWYhD3t0G9ruyz5wW7GuIkX8+3ia11Tsq9zGEx3lZmT
         gnhXBQl/jsxKepnd5jpoGunwnTsZVt2aL8vvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345865; x=1745950665;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdFsdaUTDRdghsX8VxeZ/2CwFZKCgCoBXb6SP0DHe8w=;
        b=tbNd32ZTtFviaf47AeuGb0B/qR72jOb/TwIkODvSVd+7Z1ra4eZJKdaY7SPVBgaUdn
         2/yKOmyW+rEPp1Is3lHkz/1VFkoecUMQy7xNyfivZnP6jP9IkrS5T1ZeCA9bvqwsZXmC
         jNZvaTy1WtU80eoMuHh3W3X5BUU6n0xyAYFvwLZQKk/+IPS5nlRCWhpnm7EAKQ1Maoeg
         Gv6qmVtrYsrMNxhBu7vbxcG61ZQwVIAFS05AAVPV++Bi9TeCTorQITVOg/20J3k7g6a7
         eGJ4WiSi6nGQEiSREZzfU/JBk+q5w6vbN/1M9JqC0XA3lcZEoUGNQ5lKY8BPy411Qohh
         yozQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/i3PUTc71snvCzQxSZGRRYCgEIy+7Dj4eawltnAgGN1tFQ97gyi40DsusBu2/SBBe6iAzjTddBxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSoUl4Buq/YjFFdRIWGM2mzaa8aTVWtK3o/EBJsOFQ7xGwKvm
	mxzkTCglBny53yXzyBPXbmQwi66Te5ajKqFzpNwf6fHBN82P5RzlKr8uz67jj6I=
X-Gm-Gg: ASbGnct69LPA115bDANkXiOcFpvIzDM/8rkR0MAYF+yHy3BLJjYvsD94C7oKueVv+TD
	mN7Dy5r3YPIW0Q15N385EXtYRaZOF0R6lxA43pR/h4BNbbs3JDWA8EGFvn87v53D7x6Pr2lz1aV
	DEAdO3ioaHLyNQnnFKvazIR08HqsJL+pDfJDrAFweir4X14gNZ+LKavlDS5biN4Pr7lomcG1IhZ
	Kt+Khr7yseDFChzlDQyhR68eJmzJbxpDdB4fc8FgbBrIP/TsKQMYsTCop1rXAyCYS77T2g9AUF2
	joHNPX3Vc9BNjlmZ9YpE8L7oljNwPgO/07aCMBMZTmgx050GMyLR8A==
X-Google-Smtp-Source: AGHT+IGCIWX5BVPPocsuZVlCHJEPbcYq+xpC2dCnc+JUo1mNSZJLBXsvA5T5y7KuBkfqLGA1fxMXKA==
X-Received: by 2002:a05:600c:4708:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-4406ab97c6cmr143192845e9.12.1745345864518;
        Tue, 22 Apr 2025 11:17:44 -0700 (PDT)
Received: from [192.168.86.29] ([83.104.178.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcfesm186100505e9.23.2025.04.22.11.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 11:17:44 -0700 (PDT)
Message-ID: <c05731ae-bcf1-4747-b64c-0f4b79f3587f@citrix.com>
Date: Tue, 22 Apr 2025 19:17:42 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Dave Hansen <dave.hansen@intel.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/04/2025 9:52 pm, Dave Hansen wrote:
> Purely from the amount of interest and review tags and the whole "v14"
> thing, it doesn't look like this is very important to anyone. Not to be
> to flippant about it, but if nobody else cares, why should I (or the
> other x86 maintainers)?

There are several downstreams already using this as a part of their
overall system security, one example being
https://www.qubes-os.org/doc/anti-evil-maid/

It's all giant out-of-tree patch series (in multiple projects; Grub,
Xen, iPXE too).  Ross and others are trying to be good open source
citizen and put it upstream where yet-more downstreams can benefit too.

~Andrew

