Return-Path: <linux-efi+bounces-5986-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3FD16AE0
	for <lists+linux-efi@lfdr.de>; Tue, 13 Jan 2026 06:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EF1302530D
	for <lists+linux-efi@lfdr.de>; Tue, 13 Jan 2026 05:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574830E0DF;
	Tue, 13 Jan 2026 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BALsIr6G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LtNShwKP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18A30C616
	for <linux-efi@vger.kernel.org>; Tue, 13 Jan 2026 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768281209; cv=none; b=Wh2WaLJvMJQqn0SY8xI1sUy2PitdwVSdElPy167kd9xQ7yuzG03gGljzStNyCohpQ95cD4+LzqV1fuydtAbsPcIeuaW6tTBKPIfY0jrkiCE8y4yxegivzFQxmto24g0Y63IjHn6VpF0EYAcAmAwKlW+booLnW1Efi4Xeny1d/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768281209; c=relaxed/simple;
	bh=5RD5WrNMzywR0/zMCxxyZS30F4/0MelxtGDY9ehw4VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEA3omj80nt/7xwhhvwnTG3Yn0c0E2r7AdA9DfAEUxdbSNSS9ZZ8TJ2rbDgS3lsK/WXUKShhHx4Tivd5xftFObK/GOVva88kM+nxBeqbm1HVHRdkyUjWgBHVTx+1IEE0z5mgcySvqKuUwZVKzCNiPXIMPl8R6yrrN5ICjquLdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BALsIr6G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LtNShwKP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN51wK2810456
	for <linux-efi@vger.kernel.org>; Tue, 13 Jan 2026 05:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=BZHPhzXJ0Mcz+3zRww6wyIQlO4Z+6GX7AaKUsI1bag8=; b=BA
	LsIr6GJT7JWvOyskC1k9p9VJbn3WWoTC+ig5mjlApKnZD6xZWBQ6suqFZ6hqdw+U
	WtSBy5PEM/KUvMP9mGDPoCtZMnIyKKaCWCTMXgFE2cy2WDxoIbcgqYHSbwAL6xP9
	5WeAy6J0N2HKNtJ/2dyiA9l5jXGmdSwn5ACFnLPs8soxhrm7vCxPY37l0AI9mHsL
	cYaF65LYlXzU1D/CiMNWY+vxWvIBEhdn2zn/tD1sECzHQ3SPz9Z01lvrFhZk+Ect
	2mKG3kWKOQQ7NeKPS/GO0tAj0y34ag0tYPfBrlHYq39cHJMmvediql6Rg+5nmdy3
	lxuSUSjC2zXSIOCtZfAw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6fbshvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 13 Jan 2026 05:13:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a43d4cd2bso94422686d6.1
        for <linux-efi@vger.kernel.org>; Mon, 12 Jan 2026 21:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768281206; x=1768886006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZHPhzXJ0Mcz+3zRww6wyIQlO4Z+6GX7AaKUsI1bag8=;
        b=LtNShwKPrm1Er5vIiYR5AV40poYdmE6hO5IwmDmhjEoGvYWOaEH1CI2u8o4W0rn0W5
         ejOjH2wtge7u+iF7lfux6yY72rAcuhwIFD0Cxkh51TQbazkH41OHy6Iapmy1JkxUUalX
         OAFvlQAvmvYwCfqWd6lzBBgPfKnLN/Zwyhw+zfDJpPJzWmwg1d3BrYuL5NnNBrJimOlV
         ISrY/fLbl2LebrsqAHcotIcW2j0tKa0IA9aLpqPKiG698N6vKfN9v7syXXWhLk9iABo3
         72lCbhv3fHBcDAqPKldn4yVPZdtqLWZkDLhks1IhXEQ5XEzWlyMDD9n6WkDPE/9qisam
         ckzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768281206; x=1768886006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZHPhzXJ0Mcz+3zRww6wyIQlO4Z+6GX7AaKUsI1bag8=;
        b=h5/BGL2l2bvnkY7/OwP66QmwVHFdBbsxtdMeNNg4Z+ueHkFo86d/DgEBaRdGDGFOde
         UwTNpe1gdUt5nTT+TRJcFyf6BrfnEhZTHjISgsdDMNHjGaMghMEmLYQxf4p0DOVISX7l
         PzdDJoCNte1swSPPkcBMWws/NwtB4fIr01MV4FCwWc03ZWaBRBrLP4XxZxOo+Y67gMw7
         p3eceC0rdFcEM4iOPighEgpBzSYIS5E/UW/lLjrYP0uFGevmo5qXrfJlFvTWo2z/zt2k
         HuSVzO71JMVvS+3oBmMa5j75Noz+CjM33Rs1RSubySWMSBZF9WCectlGkDElbH7aO+it
         gowQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQa3yzXQCDubvSUxkp9OPZNOFSBwZGxdk4NHNs8jyeyam9B5CwnKl846Y5n/j+vwXYV2qqOfu1M38=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfWt/cEL93EpMxTFMyNvv0lkO8aZRSzozERj+Hqc5CIp2uENN
	5GIIgVoiRamzNFSM96Znf4fSyGPIB/HGPyCNrSF8ZuQN0IqlshkDnVW+aMU44RKBcB+1Sb0Nmz+
	LqwS/Wi9JW1faq0gSmmxokr153hszUIQbHptafnXoFTUFt1QSx9tuCdo2qh7NxWBTUXBm34C1Yy
	adkwgxr1QAzypFuPN58QtRFAzG2Ro4Krkru7BkMQ==
X-Gm-Gg: AY/fxX5Tj8r6H9gd2P4ao7AgFGKG8EHyN3l3ea149ZJnWdK6MWE2IxC47h7M+gOAnJo
	OTXyCxfH0JwLo7YKJoPhNjo8S/F0hCV94o+/9ovoKIkmGvPWXQdoHl2BY0UoN1ibA+THM61bH7E
	XxWPTSX3PJiEs2ceHbWDSbfhDrzorZ/+wBH8ks2Y1ZegwDOfqfMedzxsgzES/9ZEJ8rg==
X-Received: by 2002:a05:6214:3bc7:b0:890:26d5:c1a0 with SMTP id 6a1803df08f44-890841839e8mr329033226d6.13.1768281206047;
        Mon, 12 Jan 2026 21:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExMAuvIVLlhHW04j7bO5r9MvIUOw7zMKjo1ttv/1gvnxGsx7YpOc4AlsHQuO9SAX7LPChaIbqWy0tH/97CcmI=
X-Received: by 2002:a05:6214:3bc7:b0:890:26d5:c1a0 with SMTP id
 6a1803df08f44-890841839e8mr329033026d6.13.1768281205621; Mon, 12 Jan 2026
 21:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-6-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-6-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 10:43:14 +0530
X-Gm-Features: AZwV_Qj6V3rEVBDFKYHXH8y0L1nrX3Jw3QzqIWcDU_wtoiZfXPhPZIbxRemFGYQ
Message-ID: <CAB19ukF+3tBG=nXe8is5_3xWkt7avjAQ2o5cS=44SAf0mkVPwA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] riscv: conditionally compile GHES NMI spool function
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0MCBTYWx0ZWRfX7kezXrv1awXi
 1oNixy4ZXfxQZcJazdS+yqXkCPPQsN62gYBkCVmxKGgJCXqqQ4WEhYDO/cXkIyHvih3fOLlqeqI
 Ccj+oPH+OQIizbyOsfZmX3zW89/c5IFYbnGBMKjG6cTuvXo+glsjRkeRslzhy3Mht8HErq/uT6Q
 vDpXHpdMVNZbTCgBOFQpK2Pq02JRqnSPCEm62TY9b2Kf8eUSA0U8c/WvZPkYd/nu3OmcebwvLxR
 omEVNRjeGWoKGR2F+qZPhTAuK70LoUDm6YvCoyzWyzj5Q0e9uetj7PlYuc0Q3tvkf15AJ35oKBE
 kavkqvkS+xCuCrwydt5k4dlaKYyMBPoPzgj685VAwiTkIvuCgDJ+TATdIESzy9a1EPxD1rEKDiF
 oQ9lrOPQGUrBP+72DYPyouQYN1djJue76xTq7fcsCGT5FUskqXmDJOYYs4g8dLbwWoC1+F1GwHS
 gO1/CStFV0F3JZG4xGw==
X-Proofpoint-GUID: v0_c-73pFKt1HdnKBBMywPUs3FQiZPCe
X-Authority-Analysis: v=2.4 cv=ZrLg6t7G c=1 sm=1 tr=0 ts=6965d477 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=9L7PnyXcnU1f3mQPG5kA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: v0_c-73pFKt1HdnKBBMywPUs3FQiZPCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130040

On Fri, Jan 9, 2026 at 2:32=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Compile ghes_in_nmi_spool_from_list only when NMI and SEA
> is enabled. Otherwise compilation fails with "defined but
> not used" error.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0dc767392a6c..6fd84a1772c6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1387,6 +1387,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes =
*ghes,
>         return rc;
>  }
>
> +#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
>  static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>                                        enum fixed_addresses fixmap_idx)
>  {
> @@ -1405,6 +1406,7 @@ static int ghes_in_nmi_spool_from_list(struct list_=
head *rcu_list,
>
>         return ret;
>  }
> +#endif
>
LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

