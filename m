Return-Path: <linux-efi+bounces-435-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0583E0FE
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 19:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487D7281AB6
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D32033A;
	Fri, 26 Jan 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="XVRFUuBJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26920335;
	Fri, 26 Jan 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292179; cv=none; b=G/DFXMMfB1VEXaumpqAE1QZWfevHNuczz5QpnzjoUY08DE53MKxrOsKKXskvl4Vx5PG7+Xx/xNrSzQzXF696imQQ2jid6BWOc9Pnpi9KosrkCHUbdXkrthGX23NnjliiVuGAf85FDcWQpDgeFz3p0aoS3noHjYP7NvoZiX3wMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292179; c=relaxed/simple;
	bh=X6NHVHK1AHtZ56fXP7BQYTerDml+3kcIC9CcKvSmryw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tONHFWtuQOyq72Ngw44mXbWLoypXJGbdwpNUxPq5Kk1kkUx+qLAbGXJTSCBwv+jexsJ2cjUmzkLL5IX0+rjx5ZytM4WEDBytDsRMNnOzlNdJue/Ggog34xMAeiF8amqzU/R+OfcwP1EFcVrOCtpX1+6HFdm8th1CGCnxYPn5fLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=XVRFUuBJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706292166; x=1706896966; i=timschumi@gmx.de;
	bh=X6NHVHK1AHtZ56fXP7BQYTerDml+3kcIC9CcKvSmryw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XVRFUuBJKLvBCfDhEWSWEjPdQS1RRF4c0buO0tbxsj1+H8x62pceBJSBws+r9v42
	 pEbN1cE8We7affLK7fqZZDesEUjQVooPCSm/BflRALCl9pAzOQyO2RB9f71BJRHjj
	 M1PX9GfOiwNUnm78tIvuQBygE3VEFT51cLFMxUHASTF8wSg4pwIpxkz/K85BL4q/O
	 0fVwe5xvjZ4mjMNxSixkMUbqy2bK5juuC2ChfnqhkacLcuMZbUdLIM4r7iHTUWB9+
	 wUVevkiJfymPaGOnIhZFd0wV3QmSA/YR+qVjL3/cD3ZsyETZNpXjq7P+xSBS58Pi6
	 we5OoveRmbibU6JDew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([93.218.111.23]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1rQwVI3h6H-00703t; Fri, 26
 Jan 2024 19:02:45 +0100
Message-ID: <00d699b5-bf2f-4411-af3b-30ca6fadf66a@gmx.de>
Date: Fri, 26 Jan 2024 19:02:42 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] efivarfs: Request at most 512 bytes for variable names
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, jk@ozlabs.org, mjg59@srcf.ucam.org,
 pjones@redhat.com, linux-kernel@vger.kernel.org
References: <20240123202743.1591165-1-timschumi@gmx.de>
 <20240126162524.52051-1-timschumi@gmx.de>
 <CAMj1kXGOzk4OnsxL8T7Finx8RzNu23SriY7QokAvKD=BkEvpjw@mail.gmail.com>
From: Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <CAMj1kXGOzk4OnsxL8T7Finx8RzNu23SriY7QokAvKD=BkEvpjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D6XXyUsCLUWLX1PROIwS/+6op+Zie4432dKrFa+sn/lYSE4XU/z
 vfXyMI9eqQARaS5Z2qSM2hrIjjSkNNZ1u/mJp+IMHhPhn454nSlabLA4Gpg9VPjTjZzgWNn
 GffXbBB26xE/D5n8jFiYnrr7UJJ2g4u2ux0zlB3DBE6HP+JqbYOqy8nVyHklK7kIeDSbdxM
 v/cwrLU2zacJRleW6iXnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jp1gcYIyKj8=;WALUFVM+83nxFcwlRRLlV8ge2jU
 oaFu9t6MFX7kdKVDbXmVfF8hCmWWhGN7GI+eRqrjwgbjLCjzIOmOadO15zMXhgv0as6hvuri0
 RKqNIcXwmRBpBt4zPR2O3XTm9uVp2rB0xIk4eqMPWA9+tuDJQhTRM0qFLkJoBnX56QFi66/gK
 9lFGVmHx6rADv/WM9DAx2w3xTquG6n5zBNwTWZQ6ZMG7lRlQRKYxrRF+XQn0WgDttszbnDWLk
 YGe41xiPq791SH/afh1wDpAXBCUUPI8sON7xtcZrfYDX81e+3o96GTSt4elordmDdXHsOTOz1
 3vYWuNguEd4nKPfIvE4N5rkrAWRJ2736gT4lIgBAbZsOIMR3abXnXoLTWAIpXk8TjJzT3trvZ
 o+ATVnFCPfhdu4Ibd7TMmb404QTUz148MM1Jy4IWijDvdML7K1eY4J2XKQO28/Zq9+jnrb1ow
 0pblQY4ImeadNfSsVvG7aj2G8RQ63XNoKn7M5v2Z5Yq0nnB3czDt29HyNsvGXqATKDsySHPfa
 PbCkwOQ7MOOXsbfNuGwwz6QxN3c4yZRq9+JjSg7VnnLkPh4icRb3NCci6nK9Jc/g7ZjqRbeAr
 teC2h2KJ+r0MOTvg7CLM7QY/f7TYL/gd3LSfx3ZM/UCra9CfQD3dqkYv6mirlJXfTERB6sw/U
 62uEwNssqkDPsMclI1wMOteOFVeC8MWj7Ww6r5kwqPFgmAN+Hh/1Oi82bIdVI5UxTrKGDOOzm
 bb40oEqPyLqanm4Eb5vMoEalOMg++7wORBukDw5o7t1jy9IrF+C9voAq2r23O49YBNvr/qeBf
 ZuTkQQIE2ERqA0m7cS3oyWMOHnwByabwfuLQgpl6NZnO9E2lRZVyVRuN6ggRYphbtiUZO62/Z
 F/XH3z8xI19Bfc7ZGYXPcS9PDARZlgOshjUC81lljcwTMXp+R9yluCgZGsH+nnYJdkWVzN4tN
 vj55gBUDDmKg6S0+HDoRm/M7uvI=

On 26.01.24 17:35, Ard Biesheuvel wrote:
> On Fri, 26 Jan 2024 at 17:25, Tim Schumacher <timschumi@gmx.de> wrote:
>
>> Made a patch with just the size change (and a comment / error message
>> for good measure) as requested. I just hope that I don't have to come
>> back in a month to find out that there is a machine that only accepts u=
p
>> to (e.g.) 256 bytes.
>>
>
> How about we add
>
> static int varname_max_size =3D 512;
> module_param(varname_max_size, int, 0644);
> MODULE_PARM_DESC(varname_max_size,
>                  "Set the maximum number of bytes to expect for variable=
 names");
>
> and use varname_max_size to initialize the malloc and the input argument=
?

What I'm most concerned about either way is the default setting, because
at the point where users will start investigating why their EFI variables
can't be read, their setup menu and other boot entries will be long gone
already.

Making this configurable would only make sense if we actually disallowed
write (/read?) accesses completely in case anything is wrong (i.e. more
data than we can handle, or a buggy UEFI that needs an even smaller size
to work). Then users would actually notice something is off instead of
just making them believe that there are no more variables.

Additionally, We have a bunch of misguided "source of truths" across the
whole stack (`EFI_VAR_NAME_LEN` for the structs, a whole second iteration
implementation for `efi_pstore_read`, etc.), making sure all of these matc=
h
each other is probably beyond the scope of this patch (but a requirement
for making this a proper user-configurable setting).

>> One thing that I just recently noticed is that properly processing
>> variables above 512 bytes in size is currently meaningless anyways,
>> since the VFS layer only allows file name sizes of up to 255 bytes,
>> and 512 bytes of UCS2 will end up being at least 256 bytes of
>> UTF-8.
>>
>
> Interesting. Let's add this to the commit log - it makes the case much
> stronger, given that it proves that it is impossible for anyone to be
> relying on the current maximum being over 512 bytes.

It makes the case much stronger for why one wouldn't be able to _create_
variables of that length from Linux userspace, creating dentries internall=
y
seems to have different restrictions (or at least their name size seems
unlimited to me). Therefore, anything external could have still created
such variables, and such a variable will also affect any variable that
follows, not just itself. They don't have to be processed properly, but
they still need to be processed (and they currently aren't processed at al=
l).

For what it's worth, I was able get the quirky UEFI implementation (the ve=
ry
same that can't request variable names longer than 512 bytes) to attempt t=
o
return a variable name of length greater than 512 to the kernel by creatin=
g
it through SetVariable beforehand.

I'm sure you already noticed, but I don't want to argue in favor of this
patches correctness more than it really is.



