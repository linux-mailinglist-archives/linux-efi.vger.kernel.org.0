Return-Path: <linux-efi+bounces-822-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFB87D443
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 20:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF9FB23B55
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 19:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD34F88A;
	Fri, 15 Mar 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="aQeMNv04"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967164EB22;
	Fri, 15 Mar 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529354; cv=none; b=oig1EdKIshKboCodohgy1DwaWYzfzUBkvz2tUKyY1LTulNfVfX/qbnYeo8g0+/0zlw6wvrtU/9yc5OAVLQW24gUHeSCWkdYxs3WuTUJSMnsjSQlIjG06s/wf/qKJG+j7el9t4c6CAGiFuITdwVYGZjSOIAD0Zrp6RTb3G/P2Yjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529354; c=relaxed/simple;
	bh=14+WauOWXoOMY8/Umh0tPKXDfWDItRSRHJsgpXhl9fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHbIL0liGppoG7LB3mMwjLlK9zSbi4ehgh8vb58uceN1Z+qTR3GEYzv7BJPnt7Ybr6zRB1HWjWOEQ8vX1dRmaBHA4Pxr5B5ggeLd1hJ4Dnh/c7lbXb0xa/Wyi2yuoqi4nCLBh/3RlVS148GfsbGoOF+e9Ih5fZrdh6MtcoUqRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=aQeMNv04; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710529333; x=1711134133; i=timschumi@gmx.de;
	bh=14+WauOWXoOMY8/Umh0tPKXDfWDItRSRHJsgpXhl9fw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aQeMNv041j9k2ediu598ICp/JPbI8xMURvTz0UYiRigW3hftoKTWigyifw2OB9jh
	 TKiaQdk9qheYCtxxYjv18wTKQILYwBNojjKfMg/211Spi90Pxy+z+UjjUhW0FK/Oc
	 /8NfCKLET4L4a0f7cARWhMpMu7toBkbA2adOM/8AzAUv1vw+ujFSpeg0IQX0kndKb
	 LWJon/5HuiBwKU4zv+17Q4oG0R44v7lLY6Q9BGojoFmRmZFEnPqsAtJxXj2nd79RC
	 jBI9ckqeEf36lx3AYAVKh2nlWm1SjdqDnDf6JdJfwVxiGPyL+AhQ8Cwal+NCU8hP6
	 4G4YNWwHJiRO2Qi7vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([93.218.98.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1rHraL3y6n-00YTaR; Fri, 15
 Mar 2024 20:02:13 +0100
Message-ID: <43bd1a71-8b4a-4edc-827e-6845e173e82d@gmx.de>
Date: Fri, 15 Mar 2024 20:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi: pstore: Request at most 512 bytes for variable
 names
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
References: <20240315002616.422802-1-timschumi@gmx.de>
 <CAMj1kXEvQS8e95A55po-nKn8cGou8Dn9nNhidt_QSqL02WawpQ@mail.gmail.com>
From: Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <CAMj1kXEvQS8e95A55po-nKn8cGou8Dn9nNhidt_QSqL02WawpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UfFVw9gMwa9lM1hwYPwo6YIZsnDR5Bo2Tsz8hKXkZmfFZYzPE3F
 K2CKh9u44jsPvmaVaz+0aftt9neX7oAB9nL9IXzkKnNfc8BAWevpMmtKWzV4HAuUmnC+IOn
 541AhSIZ1DQ/Yz/GjBvKdyBuBsMIBRucsgW/u/pU3a+DSrfZ3qkSQklVFvrZRfDncpAn7d1
 p1NrzzzuCzlIeHd+Dg2MQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wjgQz1qpYEQ=;zD0+u+qL942l3xaCQpXhuG3yRIg
 mfwp4KczKu369hZHXY8zYdWjeAmDqm0uwbSnYCi+rrMbEuK6Rn+EqDSHQ4oQcWIDtnCCM0eb5
 wJC0TktYfgElAe1uaFFvhwbAuI/r3g/Grj/BFDPWSyyIvO6udHZHP7KkKPCRP9xCi14QqSN92
 FNFCrcjHSdQRaq8o5cGAT3NNSPJvhHwZG4nu1SFJAaRi8MpLQd9TTdB3vsxbDKGwoWnP9xg29
 BHokxoiEh3tn5ofpUAuyWGTU+tlJ0AAt59Hjc4isWGV7phFyZ0gOv0oJ57ZAlDCZJH2mPGBRr
 Qp8H18UfgxJi95XfcqX/KoUWji+JOV7/nDUFwjloQ20rXImSPFh2kP+Lu8CTEAX+TUl607Dfs
 TB5IxioH58yLhOk90r/ZLD26cvIoy2TZJHAL1rey7uKeR3MJz4L2zxBhr4A4oP724gWj+EI9m
 OYYh7dfDDXu0fOJt1NwKgkl32kG8ENLegfcmLgmLFDqn/04KeB1t4gWYfRxactLXBFXXiRZF1
 xtoeDOhbB/zvHodhZ92NeAcBVOYwP6h392aprtTFduK5JbtHTn4Aur8r1veDx4lma0PoOKsTf
 Ue1ILVVwkO4DpvMXsV1lLl5cIitlCVcOZUPxgzqK+dQbciqTHlMxZxQbD+apwN/qmKAli+N4L
 +U1ABoG72TU/42rUIToDGrn1l2W3fWwTZMmQhhWNxqBxDllG983g4HF7arANY2tywpfcvJ9hH
 38ecIpGLVFmrFEdbpZGWi5U4N5pKg6iB5QLVusbpdsYJFYOU9aOe7QTZDill0nzID7LXbIgLv
 2GR3HKFdykvDiFREir/QzHv2jldsnLU3gtRl96IdRLQSQ=

On 15.03.24 10:16, Ard Biesheuvel wrote:
> Hi Tim,
>
> On Fri, 15 Mar 2024 at 01:27, Tim Schumacher <timschumi@gmx.de> wrote:
>>
>> Work around a quirk in a few old (2011-ish) UEFI implementations, where
>> a call to `GetNextVariableName` with a buffer size larger than 512 byte=
s
>> will always return EFI_INVALID_PARAMETER.
>>
>> This was already done to efivarfs in f45812cc23fb ("efivarfs: Request a=
t
>> most 512 bytes for variable names"), but the second copy of the variabl=
e
>> iteration implementation was overlooked.
>>
>> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
>
> Thanks for the patch. I'll take it as a fix.
>
> As an aside, you really want to avoid EFI pstore in general, and
> specifically on such old systems with quirky UEFI implementations.
>
I found this by chance while looking for appearances of the magic value of
1024, and decided to split it out because this would have been the only ch=
ange
that modifies behavior.

I didn't intend to actually use it after fixing it up, although I did make=
 sure
that it now does more than it did previously. If we can save someone a con=
fused
"Why is this done differently here?" (and have a reason to boil down the c=
ode to
a single implementation in the future), then that is probably good enough =
on its
own.


