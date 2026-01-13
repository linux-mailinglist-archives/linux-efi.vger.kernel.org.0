Return-Path: <linux-efi+bounces-5987-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C151CD17596
	for <lists+linux-efi@lfdr.de>; Tue, 13 Jan 2026 09:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F5A306A0F7
	for <lists+linux-efi@lfdr.de>; Tue, 13 Jan 2026 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794253806D2;
	Tue, 13 Jan 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCRv0Yc7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYHweU2r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D23803FC
	for <linux-efi@vger.kernel.org>; Tue, 13 Jan 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293731; cv=none; b=JEk/W6PKzB6cQSZV3WGrfnXt90vQ24lCbw7fkqZfkp0SwFszFHqpR0yBZIE/JPxra/F1LeK88G34ZfotRppZuJx+h8bqpD/xFqn4LBbAsmesm+Z9guU+27OAJnrUZDzoC6rRFAyxt6/PdgFXEGN1YRyOTcTKbqWX9vDynZaRI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293731; c=relaxed/simple;
	bh=5RecTGm365RUoJMEkqeB/sqOi4xLmrfY6YTWJNvhWmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLIHdXbQvGPumoOV1YR1tAsdYYJvvpTK9KnLrDqzN3ye30nm1BHq2wYeTv7Ts7gKSE1GxzIA5XfBjbxiedvVNFDfGBCu9nqySSV7HY5WvbAICLzisJrAKNZnqxZRhusJ9dVyDVtq3iC2070H+102kxHBCbXenojvHLmd0A5ZRuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oCRv0Yc7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYHweU2r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7AHZi177577
	for <linux-efi@vger.kernel.org>; Tue, 13 Jan 2026 08:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=; b=oC
	Rv0Yc7voplOJZGPIG+HGVNrv1yJUbGTtAr/0T90J5xBbbGRXbHTsT4PZQDK187Sd
	5dq9JJmBcFMqj3K9w8ns7D1vIt4EUn9Q5BeStCe3AMyVdBx40d+owdeDUjE2fQIS
	WW40/Ja0zGgBx4fJ0SEkTlPOP96lOPK18PN1K6X3yiJgzKGTqgiShP5DM/i6rFOV
	BV2v28SOxRuzDuFigKIM4g8VRfwYsR1QVOds9J3iz3J8pCv0ebYmNfbbQ/4lfCbd
	rp7jdJgfzwr1gMGL9LMgDeCsO0YPajQYgtx8WdlXch7AuxXggLFxLdM3VZ8GleRH
	QbsEJ6SWkMi0tkd0UcGQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn52f2eht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 13 Jan 2026 08:42:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a2ea47fa5so181060586d6.0
        for <linux-efi@vger.kernel.org>; Tue, 13 Jan 2026 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768293726; x=1768898526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=;
        b=XYHweU2rYrFhUsRdcRuRg68Fg9qhukLxGg6VyA0Sq7XUVN84sanBBYcK+7T91Gs+Xk
         ljJD/OrlGJPzs+4eHBeH/Tmz76t7nPxKigId6Tn8UOdOEpnFGC152/LCb6tZ5dxR3LZ9
         5zyqV3TMbO0SNxVruD+WL/nDtDhK6uM5qFJ3/tZDhhirUczjflDLsUEOSuy3luB6+44l
         N8Ff6R2kzV+1IN2FyI6027r/nYk/0oT2agbAJhri4bocjP4x8oJTamP146pwnA8QA3EE
         TylxyTmrTgv4bbltaMH8quWJTG5axHXb2p/rd3Jdl8ViyEF8flgH0aojybq9zROai4cR
         uRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293726; x=1768898526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=;
        b=toKxmQ+vE4barb2BZUSXE1ua9PhygZT1X0S28bOWfnb0Inws8cEruIhkFzvl3lmHL/
         a4zVXD83ZZF6DtDLd0ZSSlP0IJWcnIIcSoxeE2Bdx8OVjn18pdIviGEX8gBmv7SJp2KK
         tNn+rSpEIXcboMW6H3jjIVVCCbRx4JhInha7I5FvmDUfijNRqZaA+BQ6mg2dGba5GO9h
         z3Q5kpKHm2V2WAI7uS4qvPBg91Ut06zV0f60DL2CpBmGuatyZW0pDXsAGtglCa1EdNq5
         GOvVEoKndoV1/uQd4i88LQmKA8LdSDFZ8O+ZCQGz5hu29R/SmY7l0UI5wsbPcXXIuNHn
         Irqw==
X-Forwarded-Encrypted: i=1; AJvYcCXGnh1vZLyDGUJM0HwmokzbOwV5STC6v0C5o1GFlb9fohaN+LqPSHkvkIMnroiyd+JtyZORa9qeusM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIuUWjtwWQF3k0rJQkXQCeRS6dUE/4ZEfoHilS8EC2J796oe8c
	Cs662jJcHTOWRkk1N35PP9EXlzU7J7+i8C1byNQt0gVNynR92toujGisWELdFYuyNUPLzh4g2mN
	dVYjOdcYglW412A+S28OKAB4dhMct6dLrPkgjuDWZWWRHG2Xv1fju9GtWTQGkC8ZFaaRNsNTbz/
	FnZ+foHG3P5lTB2PFBbVmZasLbfrH9CLGqNwUPhQ==
X-Gm-Gg: AY/fxX7iKkGOnFvM8udDujt+qrf+hi1ZWuxy9mchlAtv1ksNU3iy4wWLxExD9TiZnXI
	l/zzRGgU2QMIqj8zWJdrsevoYRL5Mo1fSt0aurIlb9bRZ5/j+a0n+Ikqg5FazKJKFu81iuVZ8dI
	3vd+ShP4/P05OcETiZaJSWkSpDdT2Zfw9ZMWs5VFzBi88SGkLAawpGty6fT1LeR84l+Q==
X-Received: by 2002:a0c:e017:0:b0:880:4272:9a4e with SMTP id 6a1803df08f44-892661a78a8mr25805666d6.10.1768293725698;
        Tue, 13 Jan 2026 00:42:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJYJUOMDvWx4l8hA/velk17KC5jXEUWmnRlBHDEYXsu1TKZmLa9YbgjQfnsevRZSrydtA0WA9PnjG8rM9/N9s=
X-Received: by 2002:a0c:e017:0:b0:880:4272:9a4e with SMTP id
 6a1803df08f44-892661a78a8mr25805426d6.10.1768293725320; Tue, 13 Jan 2026
 00:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 14:11:54 +0530
X-Gm-Features: AZwV_Qh9cMywaFsFi6xL1Dz9DO_-xJHelf2IMNiJrFuansm4cMH8oxrnVD1xemI
Message-ID: <CAB19ukFj7BiyikY7Bmnu5uWidZcBhL7Vg+Yhc8exstKj_UnRhg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] riscv: Add RISC-V entries in processor type and
 ISA strings
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3MiBTYWx0ZWRfX6KKSRHgIx3Nt
 ey27YR9HnDbMl5TYda/jnnovvqXwPoOI/LE29iZb81dQZP3y2MusNKhrNZUmikb0a4ZsFyIrudU
 NoqXn6csxwwOQAVRgPq6HNNVjraMWii56CuEYetoivrmlppgS6n5wpXrhbcDoYrLUoErHO9KbM3
 WeUMsRCpAqLZ2+8lZU9+7Gc50r/LfRWlJKHrXY79BBl6h9xUrRPqUUYMSS+ZBnvSYqGgbATRhQH
 T5sTJiN2B+S/PQQI1j4/bHyhQh5l62cCAItZ1Nrz3YCUjvML50lBP9XgIwzT5YbfpFCEVP9qZ43
 uj16oe/A3cDaaz5sXNWrY9lLENhJ4/sm0e0GqCWBMkbCBdpscNFWdYI5UVyWTT/WddyyPrJHBfc
 MEizFtO15z73oesxOSDplHoTXWIDB6TM+4ZsVPhfihnFftOWCM59wS5rhGc0dGLDR6sGPQttNe6
 85EGYdyg/QwWlSU1hFA==
X-Authority-Analysis: v=2.4 cv=TcCbdBQh c=1 sm=1 tr=0 ts=6966055e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=xWNtRwkhHlcOdG438WIA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: Yo37yi6toZB3QvYHF6A3QfjcdrzuGlxb
X-Proofpoint-ORIG-GUID: Yo37yi6toZB3QvYHF6A3QfjcdrzuGlxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130072

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:33=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
> respectively. These are defined for cper records.
>
I think it is better to add the reference to the ECR in the commit message.

> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/cper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 0232bd040f61..9d591a294327 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -170,6 +170,7 @@ static const char * const proc_type_strs[] =3D {
>         "IA32/X64",
>         "IA64",
>         "ARM",
> +       "RISCV",

This should be "RISC-V" as per the ECR.

>  };
>
>  static const char * const proc_isa_strs[] =3D {
> @@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] =3D {
>         "X64",
>         "ARM A32/T32",
>         "ARM A64",
> +       "RISCV32",
> +       "RISCV64",

This should be "RV32/RV32E" and "RV64" as per the ECR approved.

Thanks,
Sunil

