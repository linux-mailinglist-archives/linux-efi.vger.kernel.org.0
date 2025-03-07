Return-Path: <linux-efi+bounces-2903-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9DA55DD5
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 03:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2598C1896B17
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121EA188904;
	Fri,  7 Mar 2025 02:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FuWqQjbw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E4322A
	for <linux-efi@vger.kernel.org>; Fri,  7 Mar 2025 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315618; cv=none; b=q1ccr1MZM6QiG3LLHDQkppin0GIQGWGJORCI5uVqp6R5KD5zN7bFWTg4Pu2AgersV9Q+xPQUmBaig61veKNjC30OzR/M5vi0M+rG+j2INgTg5M7bwS1Ieeuhx62AzmCGnghWWti285pQYw4hpA1WanhgFtX7eln5jP8KixLBUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315618; c=relaxed/simple;
	bh=YEYXLGg/CsKOrCincve+KY8W009xIGLNHMSjNI16DOw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DewBJe/lHtgNconz4L3djYS8PitPYF8CkEQKkiEx4FrQbAL4/z/2bnjMa3XBq01OTyzMoRorT5Tw6NKpVRnTwcg7bmwuLITrPkqgmsCwhNj2/7t2TscWvcVxKF0leIuvGKLlotAfQw2QJge6WKMbTuF7GJXfsY+6/uAUSrJPqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FuWqQjbw; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd049b5428so13287256d6.2
        for <linux-efi@vger.kernel.org>; Thu, 06 Mar 2025 18:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741315615; x=1741920415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt0sh+iXDwTk92DHQ0mAKFAW9RB3PuEnSeOiB/9VL1E=;
        b=FuWqQjbw3bleVbiTxE2Nk++EiZch5q88L6qp/N12jiPd/QJgZQIpRA7UWr4ztV150x
         g6E3VTvMfm0s8UFo60DTY70lCj+2UhdwCAEmJJCvszfs8rOrWsxpqey0PqV2OI49GZO8
         cVzDLZPI5w82SzqtetIy0qZKI8sHIIiefnlnLiNyN/b6lSuIrwBsa4R+ORrj0wjashjd
         achPZsMj5eYiOJdoA6kUWQWCiRWZZTUTHUGIp42+YEr/z5AnVka3meSW9OW2gklcXeyV
         9BVd3hIhZc2UP7XDe1cJ1+5cjupwbdBeefrSAoOd2JhXH4zVey4I1LsQy8gUGXF/PazS
         iWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315615; x=1741920415;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt0sh+iXDwTk92DHQ0mAKFAW9RB3PuEnSeOiB/9VL1E=;
        b=lX1ffZmn8dW9WGBJ/ndvbCPr4x9RMnmEyCEc/g/hGME2WtkGopAU2XUfFn1r2dmTdG
         X3QFRhlx3Xjo3LUNlUmfRSb1Rk88smpu+NNbxVSn+cWBi6J1P7PXI7+mfHO3xwMAKhpE
         QxbG09VOytzGEMjBTDhnp1MkeamxtRgiWWrNXgmLyJy5qu+eKbwYZPzG9cDL2+Le5niM
         GJDnxLEKbfX7IWMePQR5VTvzsJPiVAxCx4pE8I2C2mvlyh4L4jL/HMsajh8+R2sydiYB
         3AI2DqgcLjpftIDCFw3tAIz3Pt5fSXz5gtOLX/8F6d0lUAeO01bXMQiFAord2EBRpVOX
         n8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs+1yqnDBQFwoI1jhY7CRYuEVCYQwn0DYnD9pyH+v/dZPSP2mWtLDwzE+RYZWq0OMm3rNOxZPwMG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUxK2FyTGimuMdbnVigK59XdjaKmYKEC8p9On1inr/wuaW7u+
	VUyfSarS38k5dMiBy2RSfDeoM2nEhGIojyx81N1MttXT4QZflwQhK38cLxuCNw==
X-Gm-Gg: ASbGncvubuadU7wgRftyvf978F8OdNI1BDYecbdY6c4DFFaWMgA48LpnvfQl2ECVR04
	lzazyiMvQDh9OOE59z9Bx18L7LnwQpBWkW13PjnXpnPMEJ6Tx45Xb4vWgoKb1fI6H0J1kZjwClq
	6EqwBFfq8bTyg+/UhzV1ajGt92QlOxcnuQLUz2fJRTs8qXYjC4oYQuNeFz5VWGYcpQPVMLmvETl
	XiNtnBh0O4MB1LNqT+UTGBIxLeQGFvZcJE6VDfc87hapcMDASLNPZnRVJWETWG9Wbdlw+bn5DTx
	IdTEi7hqOb3+VRKymu1NZLDnNiYlCcnK/C76ZLnVoOfLClMI3UH2xU4jGS7Mux2ISajIneMgScS
	4VFdM8K1OlUUYfptJfaE=
X-Google-Smtp-Source: AGHT+IGN6nnpAum+jUxAhktZIXBBlDfUMfEpdXCUFvRXot6sALexlQzFAHfqQmACtG8oGghU6a73MQ==
X-Received: by 2002:a05:6214:500f:b0:6e4:4011:9df7 with SMTP id 6a1803df08f44-6e9005f79a2mr19925486d6.16.1741315614964;
        Thu, 06 Mar 2025 18:46:54 -0800 (PST)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7182af0sm14044486d6.119.2025.03.06.18.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 18:46:54 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
CC: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>, Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>, <linux-efi@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Date: Thu, 06 Mar 2025 21:46:52 -0500
Message-ID: <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
 <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
 <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On March 6, 2025 5:29:36 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>> On Mar 5, 2025, at 6:12 PM, Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Wed, Mar 5, 2025 at 4:30 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>>>> On Mar 4, 2025, at 5:23 PM, Paul Moore <paul@paul-moore.com> wrote:
>>>> On Tue, Mar 4, 2025 at 9:47 AM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>>>>>> On Mar 3, 2025, at 3:40 PM, Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Fri, Feb 28, 2025 at 12:52 PM Eric Snowberg <eric.snowberg@oracle.com> 
>>>>>> wrote:
>>>>>>>> On Feb 28, 2025, at 9:14 AM, Paul Moore <paul@paul-moore.com> wrote:
>>>>>>>> On Fri, Feb 28, 2025 at 9:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>>>>>> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
>>>>>>>>>>
>>>>>>>>>> I'd still also like to see some discussion about moving towards the
>>>>>>>>>> addition of keyrings oriented towards usage instead of limiting
>>>>>>>>>> ourselves to keyrings that are oriented on the source of the keys.
>>>>>>>>>> Perhaps I'm missing some important detail which makes this
>>>>>>>>>> impractical, but it seems like an obvious improvement to me and would
>>>>>>>>>> go a long way towards solving some of the problems that we typically
>>>>>>>>>> see with kernel keys.
>>>>>>>
>>>>>>> The intent is not to limit ourselves to the source of the key.  The main
>>>>>>> point of Clavis is to allow the end-user to determine what kernel keys
>>>>>>> they want to trust and for what purpose, irrespective of the originating
>>>>>>> source (.builtin_trusted, .secondary, .machine, or .platform). If we could
>>>>>>> go back in time, individual keyrings could be created that are oriented
>>>>>>> toward usage.   The idea for introducing Clavis is to bridge what we
>>>>>>> have today with kernel keys and allow them to be usage based.
>>>>>>
>>>>>> While it is unlikely that the current well known keyrings could be
>>>>>> removed, I see no reason why new usage oriented keyrings could not be
>>>>>> introduced.  We've seen far more significant shifts in the kernel over
>>>>>> the years.
>>>>>
>>>>> Could you further clarify how a usage oriented keyring would work?  For
>>>>> example, if a kernel module keyring was added, how would the end-user
>>>>> add keys to it while maintaining a root of trust?
>>>>
>>>> Consider it an exercise left to the reader :)
>>>>
>>>> I imagine there are different ways one could do that, either using
>>>> traditional user/group/capability permissions and/or LSM permissions,
>>>> it would depend on the environment and the security goals of the
>>>> overall system.
>>>
>>> These keys are used by the Lockdown LSM to provide signature
>>> validation.
>>>
>>> I realize the contents that follow in this paragraph is outside the
>>> boundary of mainline kernel code.  Every distro that wants their
>>> shim signed must explain how their kernel enforces lockdown
>>> mode.  The minimum requirement is lockdown in integrity mode.
>>> Also, the expectation is lockdown enforcement continues on
>>> through a kexec.
>>
>> I personally find it very amusing the UEFI Secure Boot shim is reliant
>> on an unmaintained and only marginally supported LSM, Lockdown.  Has
>> anyone recently verified that Lockdown's protections are still intact
>> and comprehensive enough to be worthwhile?  Sorry, this is a bit of a
>> digression, but since you were the one to bring up Lockdown I thought
>> it would be important to mention that I don't have much faith that it
>> is still working to the same level as it originally was intended.  I
>> have a TODO list item to draft a policy around deprecating
>> unmaintained LSMs after an extended period of time, and once that is
>> in place if we don't have a qualified maintainer for Lockdown it will
>> likely fall into the deprecation process (whatever that may be).
>
> Does this mean Microsoft will begin signing shims in the future without
> the lockdown requirement?

That's not a question I can answer, you'll need to discuss that with the 
UEFI SB people.

--
paul-moore.com




