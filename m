Return-Path: <linux-efi+bounces-3956-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69499AE65C6
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 15:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9391884CF3
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81DC29A9ED;
	Tue, 24 Jun 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JVpq4efq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D5298CC0
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769945; cv=none; b=KsNl1PfEqjMJZ1WvBJMZEXSIye+RjGLcxmjHDgFzrIRCA54MUMa9p2QO0t0HFwimDW9GQcf4b8C+jT0YzVjcHt2istX3vmu70xk3FOP6dwSriL4heJPtngpZWZ+Hz6FGK3dSKBt9Ic7zwxMvSVdw7N233bEfAPzq5SWCKvk6WCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769945; c=relaxed/simple;
	bh=0LPA53X8H4ymagCBZsyMppQx3xOTCD06ootxG/N4Xso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjhN13wvyc5VrmjpCn7l2vNDiFcNQgyUwmrNw5rTO9Zz/GEBYkbvaSJQPvnAIy1aAAp9LDDfnV+nmnY70hW4yH8QpvzwuuvqQYBVvFAiWmGZJNwpv7pbVvpfI3QU6bBYOb6ZChD6iVMyvrt1gsBXHSxfiladB8AwyJ6Qh5IcOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JVpq4efq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8Xn1Q021016
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8aCPlcZPHRet1BusrGg7SQrURySfp6kAO+Jcy+LWpMo=; b=JVpq4efqpmmihmcy
	EJn55aogq4pWjJXzGKyK7uiZ6oP7O+ZXxHPCvxQnRVximCZ/KRTt8qgaOQ//bICt
	NvhtuqMS+rkk2pLB/usCsEUNJ+Bfa6EWb6iVkIaTg4QdcmISwF8lALAjSCuGexHr
	ny5QL4Je9jBFiHMt+5dEGZe1ymlxjM0Rv/REeHxBmKNgsVKjt4b3NteSkHLfcX6c
	IkzoODvWOBRwV1lfZHLKz8EcwbHUFcRB38gKsRQk1pi1/SSuseuUoiDHYR3YHe/x
	cs1w7BQDPicO2+uBr6UXkekNOG2yo+G0prjLVuDjnm3qSwv7SKKxv1gFrg6lcACi
	Z7k8TQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfwtbw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:59:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a517ff0ebdso16090841cf.3
        for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 05:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769942; x=1751374742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aCPlcZPHRet1BusrGg7SQrURySfp6kAO+Jcy+LWpMo=;
        b=R+1XDcV7Ra3o1f+7K6yzbwrotbXcJCOFghFvHwtJYIMA/KZtLx5els4ZWZciiE1iYa
         rc0X7FhzIwu8/TzhAl40YADO6PvsyuZdOHsHGTIKSJUjKr8U+3lipyqjXfvDd6xhL+kp
         4Wcm8eX3tkXCWwHRq0JDTUlgoNKWKuwLFYqU7P3+CFFiJMA6ZFMrEi67Ykjujy/U9PWN
         YXTAYDKYaN7DS3O+0yebPlZMjGYhkv4AfNI6xWCQErfewUymCwxgtOoziaTxy1mNg29C
         vBx8JiWxcAM6V9rxJs9l6jpCQ71KaJpEoExr7brnxNTFOhhN3pzK9W6fp0WOGUBukDss
         qTnA==
X-Forwarded-Encrypted: i=1; AJvYcCXTIBQLpDCH2+qpUpktySKNunBea190FPtBywXqfIP7A96vP/pRbH/iNhm5OKpYb9uO1tNkrZ+sLxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1bde5UXCq6r0IQjxoamln9M3Jwm4XQp8BZwVGor4byLQ4Rm2
	qp0bHfLJ2WQojrgH0+MoSKoV75VzAl04M16XZIJbWy/8s0G6icPSF6ZtXgS1P11gbz42dVGET2X
	cAf5Lk/cmXpqLMrc07MX5dcYpP42BjZ4BLX7WkcuSowyQ6KVAXPWSpo86qKmacxW++xG2m0s=
X-Gm-Gg: ASbGncuTkzSXbpzUC7uXIaaUguKynpC6UDX1c42XmP+riO4Pz2O42pTnfXFvogtf6lp
	0fsDAs3kxyQpBjns2QG5vpCKd/S+zbZtKnYvgq9UTqpTQrHpLoMyp3ylH9U6sKZQyamAfltHPqf
	GzWAaEYbqvbUxSWABH5mcER5448gBuo7zYau+Mi3MdcqhkhXnvIonDaC79OnfFfZ58E577bfrA/
	8Q8NkHIjFGTn6O39t8ALFLRVhWUM9VlPwwNF45KiWZvr7St+n1fcxlZ9fl0OYfVYhAqY6HqLcp/
	e+qH4v9r1pUvw4l/hsTu0oBsmQfbRL4aIS7ub4LSw2CDBxG6FU8v6y9cKE6cAPhn4aSXmhkyYo2
	lcrI=
X-Received: by 2002:a05:622a:1349:b0:4a6:fd26:45de with SMTP id d75a77b69052e-4a77a245e4amr87593071cf.12.1750769941739;
        Tue, 24 Jun 2025 05:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkB3KA3dlfxr5ij4mNkZS680lH4R70235FkH4Bc6H/SrPVfJsiqULF0VCIwOt1P37LiWC1qw==
X-Received: by 2002:a05:622a:1349:b0:4a6:fd26:45de with SMTP id d75a77b69052e-4a77a245e4amr87592831cf.12.1750769941163;
        Tue, 24 Jun 2025 05:59:01 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b7263sm879184566b.138.2025.06.24.05.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:59:00 -0700 (PDT)
Message-ID: <1802e990-42b1-4007-a7e8-f6f3883651b2@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 14:58:58 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] firmware: qcom: scm: rework QSEECOM allowlist
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250624-more-qseecom-v3-0-95205cd88cc2@oss.qualcomm.com>
 <20250624-more-qseecom-v3-7-95205cd88cc2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250624-more-qseecom-v3-7-95205cd88cc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rSYc83ED0Yslu4wC9rM0UuxrOxrSn8qN
X-Proofpoint-ORIG-GUID: rSYc83ED0Yslu4wC9rM0UuxrOxrSn8qN
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685aa116 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3r7iBRhTWj2LmZrio50A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwOSBTYWx0ZWRfX1AEJiZiCoThg
 rCfoJPFfnWEAUfg+T1ENgFhuIbb7fu9ymJo2F7PrvxbzpY//1O0LNicHhAorhahbN55QAPRlaA7
 A642VE32xZsZlxWh4OKbEjRxSoCDX+VM7ZqTowbzCxTXuUdjF2a/sbsjEeR5nJLlgQQQvCFVxck
 dK/AovVbhnIyBhDudHli740TJ0Hm0xS1d6c9tG909FmXkSvrUdo+f2q82UGL5AX6Yb4L9XDRDns
 GJqDUlz8sQO7R+LnrOducke/5QiqBqNrqBkCpCivWtQiJhVNXOdcJFvk5l8MCxNZkMJ1wzCgMum
 kyQBgqplMn71W1WyjGtXqRQEszeL68xbIgrhoghzTnZ9+H4Uk6TTvByi7xgM3WDQEh5UvKJ7CT2
 Xpgs789Ete3yn4Lc0Cy/DSttnYyn/haftd/g259bcoIVnXM9iMyFnftx61yTkfBOzshFeL/A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240109

On 6/24/25 4:13 AM, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Listing individual machines in qcom_scm_qseecom_allowlist doesn't scale.
> Allow it to function as allow and disallow list at the same time by the
> means of the match->data and list the SoC families instead of devices.
> 
> In case a particular device has buggy or incompatible firmware user
> still can disable QSEECOM by specifying qcom_scm.qseecom=off kernel
> param and (in the longer term) adding machine-specific entry to the
> qcom_scm_qseecom_allowlist table.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c           | 49 ++++++++++++++----------------
>  include/linux/firmware/qcom/qcom_qseecom.h |  1 +
>  2 files changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 5bf59eba2a863ba16e59df7fa2de1c50b0a218d0..49dcb30311f9c5eae697317ec6f32ac73d81314a 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1981,6 +1981,7 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size,
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
>  
> +static unsigned long qcom_qseecom_disable = QCOM_QSEECOM_QUIRK_DISABLE;
>  static unsigned long qcom_qseecom_ro_uefi = QCOM_QSEECOM_QUIRK_RO_UEFIVARS;
>  
>  static char *qseecom = "auto";
> @@ -1989,32 +1990,20 @@ module_param(qseecom, charp, 0);
>  
>  /*
>   * We do not yet support re-entrant calls via the qseecom interface. To prevent
> - * any potential issues with this, only allow validated machines for now. Users
> + * any potential issues with this, only allow validated platforms for now. Users
>   * still can manually enable or disable it via the qcom_scm.qseecom modparam.
> + *
> + * To disable QSEECOM for a particular machine, add compatible entry and set
> + * data to (void *)false.

needs a refresh ^

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

