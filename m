Return-Path: <linux-efi+bounces-823-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EEB87D491
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 20:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067F7B21729
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813794EB22;
	Fri, 15 Mar 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="nCSMfMMs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6211864D
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531947; cv=none; b=seTf+9Z09VCwGwm15dpSyEkt/E5zBS09KO2Xm7y2rr4SNMjwsvdzj/dBlErlli1BtV4RFkApK8R8Pq9Ox+VrlNiJXnF4C/3xx4NK56xwWVboV1RGerboWJXovIUyd4pvbfwQehTU2paK+vaUezBasRu1e+TgRIhNXReEJaVCNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531947; c=relaxed/simple;
	bh=YhxeV85R+H/8+IWdXkuZ0F4ERj7d3aBJ94DFrE3son8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dr84vk8nXU7U8IS/Ygg8ZELDLAdEKFkk2bcTlRUDM2fIljJibHRzLG3M2aowOpCeetZaRVyfbGPznF0Nmw/cA8OR2D6P6630Zqcdg7TNpu1cuFQLIMJxeOGiZwz76u+uMqhOipzQVReufnz65K60GBQA4Ho5kIW3srcCNdBZcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=nCSMfMMs; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710531935; x=1711136735; i=timschumi@gmx.de;
	bh=YhxeV85R+H/8+IWdXkuZ0F4ERj7d3aBJ94DFrE3son8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nCSMfMMsZjYGqMl9axRDDhm7oa0qVEMM2mANB8+Z2dW4q+ujwkvU8DT6nG8bfXjG
	 7Fr5j78U2Oofer4Orl0t2ltJ40DATufWHZH4XOeniIVRv/yw3ts519sEiZiXQaFe/
	 +ws1x2j0aFHlmEWhXiGQCYL8ZbZkbjwUH+i4KIe7ZKC25/YDL7jYC28m7rqT7wPHy
	 FL5ES3OvNKWMBv/5aHhu5N3/N5cpZD+o//Cm496XAAOF/7/OMeBt3mI2FYPZJh7VU
	 TJuLSpPjBIP8DVxH2cTGCTViAIYfYu75q6VI3jzNx6tPgGXIyBi9oL2dF8xuOJiME
	 wumeUSlr60oPOvUTng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([93.218.98.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1r0b0S2l4R-00qh8a; Fri, 15
 Mar 2024 20:45:35 +0100
Message-ID: <dd1a8d6b-4cfc-426c-b840-382976565a83@gmx.de>
Date: Fri, 15 Mar 2024 20:45:35 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi: Clear up misconceptions about a maximum variable
 name size
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
References: <20240315002616.422802-1-timschumi@gmx.de>
 <20240315002616.422802-3-timschumi@gmx.de>
 <CAMj1kXGBtF6v=QCeBjJsVr=wdndWM0DbyFXxObsd5YUcm7U3zQ@mail.gmail.com>
From: Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <CAMj1kXGBtF6v=QCeBjJsVr=wdndWM0DbyFXxObsd5YUcm7U3zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BB5n5pQrvocFL6pxIk7UcE9CmwYizhcyWp8/gAq3JD5MfL7yTcw
 A0XzcA3reIB4YWdO9r+MuWDIBr9831sSFeksOKqDMZnPutwZJIbstPwuTDRw7oelAgiMshT
 9xmnqcedXrpv2YGlu3+KeSX19rck7CQ+WXrhiHwn8LrmXgN9zAZeBqMzl2qAZusO+9HJog4
 OBTSo3P4bLrqzqeHy/RFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qVSCNmNUVHk=;dDW1o/ge47TO5Gh8aD6V6UBhk2C
 ufXfhoVj+NHVxpQfEmst5o8H2oiBM/ENjdTujAwftIFStjwUEkZH8E4fq0YvtkZ2j0yq+J0iD
 cSfpY0armDNDMVKKfYQEmbmGFFb9j6jVc5KaOF7+mrU6XpZyU2ieRXpBaYK5seHDh1nQh5JNR
 pabw5L/t2QH5U937vDi9CeUUXu2U58i+sDzLSe0TPtQZBqvJD3TvX7shRXAfLx4c9mm1qJr3w
 wq66QlbKQy/OqgFL7yiEw3kTAanROTqLSA4kRjTg9EVZlCC/dpqCWx0B7ACdRqXJ+qRBVz4wJ
 RC7OYzvPQ+UwVY+Q6KF6hFN5dJxwB3PEGBT4Wg7oEVF1V6DYw0Ds1Zt2kDlnZ4xcwByXA2h1R
 wggUWgo2Z9aIhQTOJv4QB25aGMgRv7mGvXJmJWdDtkKb5EPnIJDViU//MQI2sH6HRCFeFHNmn
 RngH7AngCgZOCtbu8ptAPBXT6aV4vSHROr8nDJ1qW6JuDpMTlEUAsd3fcInAXV+VPUwV0Ro9T
 JOf1ob7KgCLYa04BUodn86FhAFhJX7nHYzvhucGtERMhj8qCmIokwVUNe2foPA6oE6Dx3fuRt
 bQT2EB5PvDjqkKETCc3J24BWeoTfARbthHcwgne+HCN9vketZ+w67wv8Sxw/Bxaed7vwXvncH
 YIV55Q6q5hvUrkksT1VbWbe/vQoPxqAcqG7O+wK0RKZigkWzRKBaH47MKE3K0pLPaurltOzca
 IypZykErI/shzxBfZJ7f7olb9pKnpPw8ou6pmaBKQFunRjX7LxSP2mAUWKO+Di2iryJVxPqGE
 hfYhh+tX/fZTGpUwKU15K5PqrOu+DJNhFvdnVSQP5yzAU=

On 15.03.24 10:20, Ard Biesheuvel wrote:
> On Fri, 15 Mar 2024 at 01:27, Tim Schumacher <timschumi@gmx.de> wrote:
>>
>> The UEFI specification does not make any mention of a maximum variable
>> name size, so the headers and implementation shouldn't claim that one
>> exists either.
>>
>> Comments referring to this limit have been removed or rewritten, as thi=
s
>> is an implementation detail local to the Linux kernel.
>>
>> Where appropriate, the magic value of 1024 has been replaced with
>> EFI_VAR_NAME_LEN, as this is used for the efi_variable struct
>> definition. This in itself does not change any behavior, but should
>> serve as points of interest when making future changes in the same area=
.
>>
>> A related build-time check has been added to ensure that the special
>> 512 byte sized buffer will not overflow with a potentially decreased
>> EFI_VAR_NAME_LEN.
>>
>> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
>
> Shouldn't we switch to 512 everywhere while at it?
>

We probably could, but my general aim for this is to eventually get rid of=
 a
predetermined data storage size anyways.

The only part that needs guesswork is the sizing of the buffer for the
initial read (be it either by estimating a constant or by doing a
challenge-response thing), after that we can just measure the string
once (with an upper bound at the buffer size, similar to what
`var_name_strnsize` already does) and hold on to that length going forward=
.

The variable name storage situation still isn't entirely clear, so I
just wanted to get rid of most of the magic numbers for now, and guarded t=
he
one "this would lead to a memory corruption with changed values" case with
`BUILD_BUG_ON`. I don't consider the define to be freely changeable at the
moment, but in case it seems like a good idea to someone else, we can at
least save them from one potential headache.

