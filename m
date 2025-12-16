Return-Path: <linux-efi+bounces-5880-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D296CC156D
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 08:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AC43047926
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0221DDC33;
	Tue, 16 Dec 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XTFIjUfv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y2IlkbVO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E052620E5
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765870734; cv=none; b=bBfCSVDYjJ/XfqVKepsOOuJ/oKJWGkt6rYNKg9v/dWJ816FfSo1X+Ofm6v8ULP9Wwjwo3Jr/Gbm8VM8Lm/0n+wOm551d6J78LbA9H6jmKmuHxN/CmCR+xob+CePf5qllADtAhIVy6fMlYDwTz3sCZNIcH33Wtt37/EuEa8cNhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765870734; c=relaxed/simple;
	bh=EVtYPoSK83Vy1+h2LJvKFGGxMbDwlr5oVrnogUjKJi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuB7As1G731Ah3NPeQlqJgdP5bH9UQfQnwRZLKSWvGYP796QR1Bsw1wArNeSavJGV7Bg4s77+xRT1WQdr1yq7/6QOQb9cVfLX/w83CnMLwmUOCXvo8bb20nFtrM1rdN7GkdzFVb96xsPhRaZ/x9V+e8wxE83gLFTSUfX/cViBC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XTFIjUfv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y2IlkbVO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG6nVOo2810669
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 07:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7YmBFkv7BIT1XO2FEXzhMg2xQ1XFzff8WD9iA8ZhYH0=; b=XTFIjUfvzx+0WxwS
	dxYZGhHRtRb7qI1JBA4pcqy6vbKSOyzJdExYWJot4nyNC5bP1PQTwaol4/9nrFRR
	cNpfYq+0xplBniApzuR6QM64JR4xlSIG1ySWQmd+F+q6RI4c/HRYUQu+unYmDuNv
	ovH/RzLAz31fw6dCPurnScEOA3yMEOiKC7huhtgQOpmNCpjlfq4Dztq5qNeiqYLY
	jHTLvHGqClBMGi7s6HFS3MNm4vkXZAJdCNq/6X4u1Sqy1Q4F4BpI2jYe9sKTsM8i
	1uZY0wuJCCs9kowVxYLa+FqZz23OiYWlzDcNPQ/wsbuvItrhExVtvoTS5xD/yNst
	ibD+sw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b32gar5dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 07:38:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bce224720d8so8053576a12.1
        for <linux-efi@vger.kernel.org>; Mon, 15 Dec 2025 23:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765870731; x=1766475531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YmBFkv7BIT1XO2FEXzhMg2xQ1XFzff8WD9iA8ZhYH0=;
        b=Y2IlkbVOZfKbmsmiUf21URSRg7ynnteK+KhpgS3bYxSgc9IrUARfongdPfiSez9o2i
         /TSF2dTtYlztiimvLDhH41ux18V6DMvVZsUgU8mfoehTZwOwNToMghR8w4QU4m7m2agn
         XAbF5r0+Ko9LN5UTcj4PMz8fL0mRvXaWmccqOT0vaSG77pnaj0+1RPp1WI/d1NRjdgA6
         G3tvfFfKx26EKigXqtSzGA5bwZ4GXeMpEytgk0aYIJLtRpugnVNv+tAT1QH4Q2hQQPJ6
         RDNI1NNyzuLultZCuAEqQ55l6bxvnl3Rm+crEUfJCoUFQLUgCAo/px54SsX+9EzjuL6P
         eSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765870731; x=1766475531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YmBFkv7BIT1XO2FEXzhMg2xQ1XFzff8WD9iA8ZhYH0=;
        b=KQYFS5wLGBLaduWOgBZ4DNBE0Qg564X8kIVIvoMzStd6mde51nc9R41LqUpbUKE6JO
         B63hm9hZqmYUclekMNjrpJtsfcUKd8BTB2ZuqAraQmYye5JHxpD8g1TepeF261OAmIHZ
         /SjfPqV7kM8f6yVxPuFtdvsCO08D5Qbz2pV61hXfaji9ijFDo3rNQMwUu0I7xnqSx8/3
         0fO7uJUEvaK2TU7lUk/ZipFSpD9XqavLyt5iQQATGlxPBxLr/BO3kWM2zjSROe/MUgDi
         oa3hjAj1+Txf6h86eb2TUSIytaf2Epq4MmG9yvguoBZxGXgawKqlvM25+8NnCOSVlOkE
         wa0A==
X-Forwarded-Encrypted: i=1; AJvYcCWnl72XLlqn3Ny+6U9iMkDt2wcdRI2XCkr8Qpz1AQrzdkpAOE8MLy1H0lRGlS7ngaZFNDU0ljjD4yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOQu2nBqkPER1cE1fKAZO0l7WMCzYvTTqHz4NBEOOJTJE17hy
	1uu8pOWDoLERhdXRdXXNyz+NfGd4ajQRUWdDDOsmon1SLUdj4zMEgLC2HJ1pdHCngy0AFfUSRAL
	X4JmHHWwC0ktC5Tz8ZCtXx+1JndPIFBkqKLbRgcLgFdTJ3/aCxcEk+zQWTXDLyat4trHK3EP5gj
	JsqZjbh/JKmgLszv5mna3Dit1IWhvYTter5SquDw==
X-Gm-Gg: AY/fxX7FX5SmrN7rbiMPGWk2FzARUKCDBIGkVBeKhT0R/uZ3R3ucXSclkhn8DxIlWoW
	lKwz8qmFsrdUgd9HdvjO476bw0qtvneM/cfoCg7oh2uLJjHaR3viXwMVpY2GyLLsYCjMan/v3WY
	ARre/UTWq3PrRgDtUaZRzgQz1Ik1+0zmAyRFhA3P60U8nSkSba0dJ4UNGH/tePNUddt8Y=
X-Received: by 2002:a05:7300:2a9b:b0:2a4:3593:6453 with SMTP id 5a478bee46e88-2ac2f85e872mr8049907eec.3.1765870731070;
        Mon, 15 Dec 2025 23:38:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgAxeScCHPFScnumP+kyrXe4heJGwYVQRSxj+hObliMSDxJWWHv5hYUxaMExJMrxhceQO+g6cVj0vLQa5OEdY=
X-Received: by 2002:a05:7300:2a9b:b0:2a4:3593:6453 with SMTP id
 5a478bee46e88-2ac2f85e872mr8049887eec.3.1765870730525; Mon, 15 Dec 2025
 23:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <aT--ox375kg2Mzh-@sumit-X1> <dhunzydod4d7vj73llpuqemxb5er2ja4emxusr66irwf77jhhb@es4yd2axzl25>
In-Reply-To: <dhunzydod4d7vj73llpuqemxb5er2ja4emxusr66irwf77jhhb@es4yd2axzl25>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 13:08:38 +0530
X-Gm-Features: AQt7F2pIGEo3k7l40jiSNtQzSXPgQLv36wLttu_75OXJz9aTmVe9GGZBfjh5ELU
Message-ID: <CAGptzHOOqLhBnAXDURAzkgckUvRr__UuF1S_7MLV0u-ZxYEdyA@mail.gmail.com>
Subject: Re: [PATCH v1 00/17] tee: Use bus callbacks instead of driver callbacks
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Vcb6/Vp9 c=1 sm=1 tr=0 ts=69410c8b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8
 a=sfbzD7rgGHNppxHmi9UA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: N3DmyhQ2vIiJh-u7mC71Ct9RKXU2NKxY
X-Proofpoint-ORIG-GUID: N3DmyhQ2vIiJh-u7mC71Ct9RKXU2NKxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA2MiBTYWx0ZWRfXxv6N+he7S5f2
 wfCsCjxkHvXbOGa1UKcpn4zMrXPkGxLSd87u7c10/ck1KJXrqQlsN86PrBWQBYGbmte/+MEKE6T
 NEYrv3aBoR75ywGzLwxH7TEQIwL7b+fm6lLtzTFaA3KnpOTjL8b9RG6H435ettucQEPbeq2psrG
 nx5w0uHHBKWUm/Fy81dUXmQmECLdv2DHwei3SbfPKIFz5ydGQpw9Ml5XskI3j7KHVQyM9KbD+gA
 Hjh74cyPXM8w3jk7U4qgp4Hp3+f08hcalX0dWy34d5xYb35RFIpOpXMIzgtWL+dXliH2XAnajvB
 O9krVhoGFaPLB/cBzyYcb0CxQkJX+upSno2yqp74exNy4jQt5GP+bk7M49TppKu+x3kxfb5kFb1
 a1O/MDyoRvuf/10Flk6yBS3kHqNsIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160062

Hi Uwe,

On Mon, Dec 15, 2025 at 3:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Sumit,
>
> On Mon, Dec 15, 2025 at 04:54:11PM +0900, Sumit Garg wrote:
> > On Thu, Dec 11, 2025 at 06:14:54PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >
> > > the objective of this series is to make tee driver stop using callbac=
ks
> > > in struct device_driver. These were superseded by bus methods in 2006
> > > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> > > methods.")) but nobody cared to convert all subsystems accordingly.
> > >
> > > Here the tee drivers are converted. The first commit is somewhat
> > > unrelated, but simplifies the conversion (and the drivers). It
> > > introduces driver registration helpers that care about setting the bu=
s
> > > and owner. (The latter is missing in all drivers, so by using these
> > > helpers the drivers become more correct.)
> > >
> > > The patches #4 - #17 depend on the first two, so if they should be
> > > applied to their respective subsystem trees these must contain the fi=
rst
> > > two patches first.
> >
> > Thanks Uwe for your efforts to clean up the boilerplate code for TEE bu=
s
> > drivers.
>
> Thanks for your feedback. I will prepare a v2 and address your comments
> (whitespace issues and wrong callback in the shutdown method).
>
> > > Note that after patch #2 is applied, unconverted drivers provoke a
> > > warning in driver_register(), so it would be good for the user
> > > experience if the whole series goes in during a single merge window.
> >
> > +1
> >
> > I suggest the whole series goes via the Jens tree since there shouldn't
> > be any chances for conflict here.
> >
> > > So
> > > I guess an immutable branch containing the frist three patches that c=
an
> > > be merged into the other subsystem trees would be sensible.
> > >
> > > After all patches are applied, tee_bus_type can be made private to
> > > drivers/tee as it's not used in other places any more.
> > >
> >
> > Feel free to make the tee_bus_type private as the last patch in the ser=
ies
> > such that any followup driver follows this clean approach.
>
> There is a bit more to do for that than I'm willing to invest. With my
> patch series applied `tee_bus_type` is still used in
> drivers/tee/optee/device.c and drivers/tee/tee_core.c.

Oh I see, I guess we need to come with some helpers around device
register/unregister from TEE subsystem as well. Let's plan that for a
followup patch-set, I don't want this patch-set to be bloated more.

> Maybe it's
> sensible to merge these two files into a single one.

It's not possible as the design for TEE bus is to have TEE
implementation drivers like OP-TEE, AMD-TEE, TS-TEE, QTEE and so on to
register devices on the bus.

>
> The things I wonder about additionally are:
>
>  - if CONFIG_OPTEE=3Dn and CONFIG_TEE=3Dy|m the tee bus is only used for
>    drivers but not devices.

Yeah since the devices are rather added by the TEE implementation driver.

>
>  - optee_register_device() calls device_create_file() on
>    &optee_device->dev after device_register(&optee_device->dev).
>    (Attention half-knowledge!) I think device_create_file() should not
>    be called on an already registered device (or you have to send a
>    uevent afterwards). This should probably use type attribute groups.
>    (Or the need_supplicant attribute should be dropped as it isn't very
>    useful. This would maybe be considered an ABI change however.)

The reasoning for this attribute should be explained by commit:
7269cba53d90 ("tee: optee: Fix supplicant based device enumeration").
In summary it's due to a weird dependency for devices we have with the
user-space daemon: tee-supplicant.

>
>  - Why does optee_probe() in drivers/tee/optee/smc_abi.c unregister all
>    optee devices in its error path (optee_unregister_devices())?

This is mostly to take care of if any device got registered before the
failure occured. Let me know if you have a better way to address that.

-Sumit

