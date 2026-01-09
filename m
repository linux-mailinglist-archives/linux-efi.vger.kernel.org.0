Return-Path: <linux-efi+bounces-5981-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49130D0A681
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 14:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C53D830124CF
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94235C185;
	Fri,  9 Jan 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXhEiw/2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PLDwYgBf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955835B15A
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964910; cv=none; b=Avf4cG1tu2ax298qA68X0ZhhnqKtj4xLaQX1ubfH60dn8a9YWGB9DEg2PWStbV6bW08JDdjy3LJ9wxepjU2kL3fj69lXRPN/vGqC37YrZCm5ddUJMl9Z+GUUEateGg7xRdPkchT3cQLqhSBq6uRlw6xHD2Zgt+iFivmayan5Vho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964910; c=relaxed/simple;
	bh=eVCQ0zFZa3LMWhX4okqjj1sUXYynRau7Uwu2NGHlf4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijsOAERzXDzfBR8T+L9hmbrRQDbXtZTx0ixkAcyczfYPdleb5Hz/jHTLmfawiFQTQeTWmE+u+vYBGifCc3aOL5JetTQjho68RQnZIUq+8sn5krogwnUYO30xcbKxFhxtYbx0XKJitbyCdiqnnJkl9TUHGby0Vqj+oSLMDWb/U5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXhEiw/2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PLDwYgBf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6096ffR31953231
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 13:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=; b=WX
	hEiw/2oKmYNFFdOqfMrcNoWZvCEqAypOl56bXLBwan+58yVJepe2ID5MXdOKx5Th
	svf0Hvm2K9pBhc5BaFMmbV6+ixlWG/qY7PUoPmPj6UQYkiYUSi1Zuexh9iym6On5
	OtOrOgO6976pOqwrSe+Pg1b0qq+rI01wWSmKgB5bvPUyRzdO2lOhYsJH4zOV81X8
	DUTESvIyxrLj3UaUcVWBd0d3oos4IN6JqirVx+/x8K+UbCXvzSVRKIvmIj9AQs/k
	5jmls5NVpKBnrJ95uT0v5OdFluZW1/o2jTQ+LwUCHoHai+/gdC6Eqm58vy/Idl0+
	zrDP8C+Rq+GjnXW6RD/w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfdabe4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 13:21:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ffb4222a4eso78543061cf.0
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767964907; x=1768569707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=;
        b=PLDwYgBfb6/gx+HbOVd6uXCw2Wa6epKfNL9Jlv3DmHZQPbldi2r2V2/HfrhEBTAW39
         eWM6KTGdoI6nnIYHfUy7n5HKTxF+U7zP8xMUMdSOSX6WysZ5aROYiU158wAfCYtpZVM4
         21jHFW80mZ+pepbVgiq9KK+8F1WlFSjYfCMOfnQPjHeNei+0XyHzYgXyogqpwvXQERZi
         SP32tNUVoH8KIvfXJ2ULAh6o74f71RU6Va5HNHnRpQ0rAfBA19lapRSzdimOS023cqLg
         o6jwt+noOLCx0h2Us74BSqHprVm3EQU3BLP5jjJq7aUyAuMCRbDITRS9SpMykunH+3BK
         dRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964907; x=1768569707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=;
        b=YBTD/G2OOQRW4aK0EhGIcrOevDEYG0GITCtIh/GKKUqmFMF7ru1sie2Rsx3uFGcq38
         qYmyc3qODU0WZFfdhNEJsaozi5kxJ+Oed0Uz+LnpZJrJTegpZf1mFAC8fQlq+GCQeRv3
         7F/tkR1S8S1InPX4izG/17RKs+l85aJEvmaOv6pHQibiamZLPm+qi9Fp48kfrROaCbED
         SVlZGFBbV7Ed8lPYtcK2fCqg+6wBwt/yT0XHxgNiU+u2uBMIE8n3h1FhIkGwriqNd6HX
         bj4kBu1GPMUUhujmKcNTgRY+xyZDyABeJsA2C99lz7XdFExd3RQlPQtJyCS/F+dh6EbU
         0C0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9OpA6bt9CWc4Esda93XXaPOecGvEKXU27aEK0xirzWICYoIB/1FSSrp+LJ634269z9WQcwtlLimA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11eKyMz+UEajlp+AIriuOw1vwGolMrvHbOixnwlNKdPN1TNTo
	TrS+e7IEHEGITAIy2iA21es4E2EFoip5muGNfbw1UH+SaMVfsTBGXaghlAB4AT9TkjC547M1yDE
	/Lk/47RilFPX8RE9v2M1kMZ4tBcKoxV2QGS52wPvaj1X86bEazHmnT/iuDlcqJTIfW9eH9yxjpF
	ePWXE4Q8eCZdBRb2LI3Tec7yB2rRzlAY36wLyQ2w==
X-Gm-Gg: AY/fxX4L5dCb8a/fLPdkWcN4yVji0XgbHpHFiR/6t0VzYNgSAV2wRWq4f7wmkbsml4N
	egTAvAJKRrQGMNPbOyTtglEZqrPgFzZwWi3ioQusF95eExfH4WqbRUt66BP6WhZTYdz3hlggaUp
	mt6G1gZgSwwlG1VCv/9yavoanC5IhjfAzZmjZygJVRWLe+xeR1XOyBGGvUzBiaowIkPc4=
X-Received: by 2002:a05:622a:14c8:b0:4ee:61f8:68d6 with SMTP id d75a77b69052e-4ffb485404emr127525371cf.6.1767964906817;
        Fri, 09 Jan 2026 05:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECkusQZQQHBVt2A44gSkXhBbZXUvr9pmoh9OZwBivjqjivaJRNE2lJCJ8geRdznbFg0XMQMJzEHdBSKjeUGqY=
X-Received: by 2002:a05:622a:14c8:b0:4ee:61f8:68d6 with SMTP id
 d75a77b69052e-4ffb485404emr127525011cf.6.1767964906406; Fri, 09 Jan 2026
 05:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 18:51:35 +0530
X-Gm-Features: AZwV_QjUVwGXO2R47NOUKBNVW8AqeLgnl_83gTKQ6qB3PBktNV8dMcQ64Qr-7zI
Message-ID: <CAB19ukG+_a+q8htOMxXnQRByprAmfPjCfNeHBh-3GqVeQbNMMg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] acpi: Introduce SSE in HEST notification types
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
X-Authority-Analysis: v=2.4 cv=Ue1ciaSN c=1 sm=1 tr=0 ts=696100eb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8
 a=a1NblK7KE1KWh-jXdIsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: HljA-W6mHB3FdQNmofX-Ve7qTDwbeQW8
X-Proofpoint-GUID: HljA-W6mHB3FdQNmofX-Ve7qTDwbeQW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5OSBTYWx0ZWRfXxV9UdWq/IwrU
 oXo9Yl8sMpX/Lml80Y1GA2c+7QHIKOVWw3aPhES04RRLKbOQXZBYxFqqymJHs7LNxFfBcCG4Yat
 05MHbibNJfup/3WqX0sqyg67s2vDc9pKB7cCxlMoyLfRY/fdx2tfx0xTe/qebCb6auD9DlegQcV
 u1/bmgDMzFaMndsnOdMh+67WChpPFTvn9uNnsE7bVfSmntkRSljITAhnGwNQEE5KLw4S7g4okEl
 Kk5IO09ErJx/QJEfyT+ja50LE7lNTMCL7ek/Dd6Y3PpkE9lsBuQO7IKwh5sYfDrTFH51MziA94A
 vqEuAdtm0pQx/gHA/0hdfM7UyIrLKRp8J6X2WPt0aZCPjBA0BBwn5MVJVGndBhNwHwCFDMHYxxY
 Dl1opibSOQ+ZZ2DQpMzC2ec/lMQZe6GYuSRzZby5c7yw8hOllwhY4zJs8eRD7uppfjVsr4YJnSA
 6c6XBIkAtjEI7sEijvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090099

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:32=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Introduce a new HEST notification type for RISC-V SSE events.
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Reviewed-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
This is an ACPICA change. Please submit a PR to the ACPICA repo first.

Regards,
Sunil

