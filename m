Return-Path: <linux-efi+bounces-423-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3066839095
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52FE2B25C98
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0B5F565;
	Tue, 23 Jan 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="FmYtP6f1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2E5F573;
	Tue, 23 Jan 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018144; cv=none; b=mFruxO+YW4O6VuZys/K8md0gGvK+qVuZsRtqkPi6pA/Lv4YKN4Bt41QgVAtTB3z1wQgTUoNWhA9BqTeyvdiK2H8bqnRp8G1JweDG6S42awrlBl7AyKDQtldwgYH9cpv0zpp1DyrTHSdxlIIFxJTt94NQDYNMIl/uNIHsyG7ena4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018144; c=relaxed/simple;
	bh=3OyV8v5LLPqhjlL5KP/T8LBQ34VCIfqmKY3lEyUONQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/dpC/CD4xqRdi0G+yQD2ZhfD7tiFHoz51qJt8hKgmvdMRKVRqs+BHP/rAmELxFrc+6etfjTRjoBNEwBGsoz0P4TdpY4LfNexgX/XlV+L2SF4F6+oWvXTA1a/yUAt0Jzy2SoZ4BgVSacSLH/8ENhpY1SVuW0D06+MnSnshGhbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=FmYtP6f1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706018131; x=1706622931; i=timschumi@gmx.de;
	bh=3OyV8v5LLPqhjlL5KP/T8LBQ34VCIfqmKY3lEyUONQc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FmYtP6f10+n+a3weDkYSizyzo6FtJlAv2WkX/NAf7apprADBHPpCOcw6dU3tg6dp
	 2Dta4+2ugesDk11T2mDFyPESuNNvTJN/lRZU/nfc1kxEbBUI3QJvKfCP8wQMIDbi8
	 APWgpPclJSetdpWipeJfOpIhOJ+bBrmPyyxTt/T6Fu2OEH8TNWFqxMDvY9fWx7gdn
	 IL76bbR4uaTYTxJ9lrSw0AEMe5YkXJmM7wD7NHWEXyGVkEQAGwRtn7zG4LfZHDXq4
	 z/J2DNM1Vgy0QU+xS4v4y6kzS7uB+1AZUK2Talu+Jj2vz3Bqqb1NLYemQFpkVNYPi
	 ftGZXVW9FCKcOnCzoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([93.218.111.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1rLjoJ2FXE-00FTEX; Tue, 23
 Jan 2024 14:55:31 +0100
Message-ID: <223a4e75-2e06-4bc6-a70c-823f0eb308d7@gmx.de>
Date: Tue, 23 Jan 2024 14:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efivarfs: Iterate variables with increasing name buffer
 sizes
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>,
 Peter Jones <pjones@redhat.com>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
 linux-kernel@vger.kernel.org
References: <20240122231507.1307793-1-timschumi@gmx.de>
 <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
From: Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6NUN+h/cC+a0ZuA/ypHftrOHY+j+X9TGcJQMD7jsBA9WCAIx2Gj
 jkh9ob0br2qFqvCtVBooik+GlcGZb1jeBp9+plncfdBIceqPFnuqO6BS/r5R4Bd4dY37On3
 loPB7SDmqXP9CZhXL/t94IHRGjZ2/h8jglE7hbb90U1y4a7lM7doJivSrJJtWtJt9S+qvYW
 KLVzMVnhdfOjO0n/0P/3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l9QfBb6Avjk=;CVtajfVn/ov+5nD+4lYgvKjPGnI
 qlW3e0LXqNfU2rBzJ8K18xi5VxjwkW9msjUbM2P+qEx6Hm1CGfIxZ8Cj6Bq+gv7s0JTWHXS10
 oZpvA8V0PXAmfIN/TkR0eWas3GPP4VWUTGmoiGsoZHgvkEaauJwzfeboar+tdHn2OaU8qtlmO
 Z3cdCARtoD2+EdM+bfFshXtCWoM8vvueBC6Hv7iVTc0dD0eMOWWIWm1CI5s9wH8On9A8FIg8Q
 GWXNVwGIdokW/uwrHKi4/8SCt8+Yn5FmqfF0fSxmGdsOicdtETTV/PcUGehJVKSaFEjlM4ZNI
 PS6lwdKpIvEHX2363EcWfyr9Av5o/oCG4z1EY2zwIpk+HeEvqk7aImdnGDhXB0cT30Hh0WA2N
 eSWxmmmQLhkrha8ldNPkWGaYLMWsEgqz9Ip3I1D4kwMoiaglfqWNBvEBWt4/0R+5fAVrojilj
 omHO/W++Vim8N5g6OGgmImuIKcfQ1lUIvhkuf0WWDT6cZpVmuycNSf8A3C8Yd7kby+yuwMlQs
 E7+3pd19IyIqnPSlvAlbyWZhIuNUVUMGZ9gg05XgXTuWmkdI+1EYhxORT/OptMEK115Qc0m+4
 tjaG/RWcA1IFgnDgeW8oPsCwBOdZJ+n1ce5qOCw7tdMe1ks4Gu+vX+OfAYdoytn3IquOKq3HM
 9UvP1p02U3Jk1CWteLvTJpWSINAr79ikK/AeQ84KcCpHNA4vYEE99JxOXiOSqnCGhpn0sjoS+
 E2AzOcVjgL390cOgu+4OQ2nWx5WcbBAmQAN7lwOj/1siwdm67YPRZ0En4LaMDUnoHm1MJuuMP
 rEzz33ahaIQld2CmbzDgBl/Kvvrbnc8BCKJh61gumQHHh8VN5DrJA0cGl0aeMmvku1ugBT9Og
 S+zTOIoRSXjpycverfSvDomrcCfhC6H4Wgm9S8VhF8674WRnysDO2xD+94OZ7C4m99U9PLNyr
 yhfOqvLXDS5GFpwqBZO1GLNeySs=

On 23.01.24 12:24, Ard Biesheuvel wrote:
> On Tue, 23 Jan 2024 at 00:15, Tim Schumacher <timschumi@gmx.de> wrote:
>>
>> This sidesteps a quirk in a few old (2011-ish) UEFI implementations,
>> where a call to `GetNextVariableName` with a buffer size larger than 51=
2
>> bytes will always return `EFI_INVALID_PARAMETER`.
>
> I wonder if we might just reduce this to 512 and be done with it.
> Presumably, Windows boots fine in UEFI mode on these machines, which
> suggests that it passes a value <=3D 512 too, and I don't recall ever
> encountering systems using extremely long variable names (i.e., longer
> than 512 byte)

I'd rather avoid introducing deviations from the specifications on the
kernel side as well. Someone or something might legitimately set a large
variable name, so we'd have to have resize logic anyways (to resize from
512 to 512+). Also, as mentioned on the patch, I'm entirely unsure what
the size ends up being used for, so I'd rather err on the side of
caution (most importantly in regards to the buffer size).

Windows _does_ boot fine (and is able to read all the variables), so
they presumably start off with 512 or smaller. FreeBSD definitely starts
from 512, but they also implement additional resize logic.

In regards to complexity of the proposed solution, how about we approach
this from the other side? Start off with advertising 1024 bytes of
buffer storage, and cut that value in half (without actually resizing
the buffer) as long as we get `EFI_INVALID_PARAMETER` while on the first
run.

If we ever get `EFI_BUFFER_TOO_SMALL`, we know that something is wrong
with the UEFI implementation (because that either means that something
claims to be larger than 1024 bytes, or that our assumptions about the
quirk don't hold up) and can bail out and log as appropriate. That would
limit the complexity to the machines that need it, completely omit the
need for resize logic, and would still be specification compliant.

