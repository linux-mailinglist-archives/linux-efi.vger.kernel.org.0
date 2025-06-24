Return-Path: <linux-efi+bounces-3955-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C896CAE65C1
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ECB164288
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B12989B4;
	Tue, 24 Jun 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NU63bKQL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B39239E7E
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769822; cv=none; b=QiCXdGW9mf1BwNyWHuRFkVW4hKjPqvTNrhV6mHgXrQQOZ8i1k2Gq7JIgEeua4teL0fVZuGCEVoyBADTbyZfp8y9FxsNbslxN0mHwLTHrkfT1hdR1kCGuGn9qAAYvJEU6GKJbO/Mnf8ce1UvTyo0EaSwVp1Ts+utL3Ex8aviajFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769822; c=relaxed/simple;
	bh=N+HKK2qiEo4toQruchw0ESiDROQO/pd4T87mTB5Xuf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkLte0TO/5BYFCdStd1e6JGrwEohDS17C2FX7shmaoKU/SQ3NLbwKeCmvJZmBeju/5pcVigYDzb2d+vLLObQcRxhSfD8lESN9A1Yfdux6tIqoyyHe5I5g0csNJYoUBZDWCwUB49ppQzvgog2s5CYTkTQRfRfDpCh4USmTegNvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NU63bKQL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7JvVO021620
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vGrSPNV0AkW+/pxO0NzMJP3MsnaMmBqY4s/rKDI8CE0=; b=NU63bKQLaxX/u574
	FkCHrn1L1VKjT/Aqzhh776KsaQ8P4h9FQ+vCUkxdiR7BFSLfj9GTycKVUnsLDivQ
	rn7e6dkDMr1brwA89079MtqRChDsXq+eY75WDhX/VxD5F5S3kPxU0qbbmJ//Acj0
	HBoLpRN7NtVrDRSa7L8wn5Y9hSiYUMTR3FAF0NzKFh8FAJj5xbruv+o4CbwpPPZT
	kF6uj8Rtk7GE1ZTFLCHbvg2BVO+nZABS9aVZBemYGV0mLx+T3EHlk+ib39eOB/Tp
	elfcldVkIJ9j6cKqi3TsmGvaKgcjZxzrNA9DslQARKfImb2pVp2hi14KJloJR1qH
	kfvMYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec266dgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:57:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a5a9791fa9so17032671cf.1
        for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 05:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769819; x=1751374619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGrSPNV0AkW+/pxO0NzMJP3MsnaMmBqY4s/rKDI8CE0=;
        b=EQu0bMOsSgf836PH6YTAliH2IJWoCMLMbeMVysK1QM73eYwW9E1ZBR4BSiREpd1OOb
         0vOh9DLIjJIvxRr8SmBJLW3AXHw8LoYX8NWwXrGFY7kY0VFCKK8Gd2LH9vKirz9pI45Y
         umSDb1xfd7gSOhH/MWnzv3V/+VdzF8+LF4GvHIrlAL0JNfQAUcYYjhRETfHjLUhb+x7Q
         ftTdndPgJv/skhzZI7np+h9UU3mHOXk8eDCe7hSkSS/QlymNyAfXLpSVZC1fSxig9mCQ
         QBdGowwEITN+L/Jw67w4fF1NoI40nUnByNMzlMhRfbbXxOkmoivOCAqbZ4DyztwMi4FJ
         sntQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYsWgkSrrN90uR8z/aqC8WE2nsFCy0Olu10CEBaA/7oBNrCEpnuUwV2LtlV3uzihia7CEnaaI0pdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GYs8L7Aoi3QzQNj+BlEbkslYsW6OlwigOqoxNRA3naeKyNBy
	N58QB9GSv9hCynu0lYFhcPohMRWJ8dV29/WZeWWEi9B7BUDMHTFBBUFscR6PTeg6WJG/yc7gihe
	ZOYfRj5mDSqs3402cRn/v8hyVwEZGZGhGjTbt58lFsQ53DWTk09PO0ppSZaXs638=
X-Gm-Gg: ASbGncvTiaV7nGm0yMqkYgy60mEWrEqXINMbC1ufqb2fGy6xzMXgxy7nq5Z6vxaLCwa
	ic+pidEqCMTCoxZesfDe+sHspmAnzf6GptymSLlOhx9xYm7/L7zco3fNZQ5xcusk1ZEwScPSnNh
	Lmj9txgMR0qqi61GoQm0QwInjIflVwnSrs2w0H/XJv/HtrMip/m1u69MOrWIw7mPgrCx3f1a22R
	Pml2niwcB6VsiJIukPkKLkYnQ0HgZEYtV8dM5lhZjBl23yboxYCJqlCq+tkqycu3K0u1rue1LOf
	JXRld4FleP4eBjTHd8f+kbIJk9LzX4QtHvpvxL9CmSTc6nFZWOHQMiFETfHgizx0aot0ugm2DIu
	E0Fk=
X-Received: by 2002:ac8:7c45:0:b0:4a4:35f2:a02d with SMTP id d75a77b69052e-4a77a1e7146mr97580941cf.7.1750769819242;
        Tue, 24 Jun 2025 05:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHyHh81fVxV7HHXyMJ4tPlwaAkz4BjJUrdJoA4XGyb3qT8OL8kxhikzSXPBfp4fMeHgjLsSA==
X-Received: by 2002:ac8:7c45:0:b0:4a4:35f2:a02d with SMTP id d75a77b69052e-4a77a1e7146mr97580791cf.7.1750769818842;
        Tue, 24 Jun 2025 05:56:58 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b672e340sm33610366b.180.2025.06.24.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:56:58 -0700 (PDT)
Message-ID: <cea1e9b3-ab14-4383-a710-50bbaa509f1d@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 14:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
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
 <20250624-more-qseecom-v3-6-95205cd88cc2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250624-more-qseecom-v3-6-95205cd88cc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwOSBTYWx0ZWRfXxG3sl0XAv1by
 nE6Z7aRIwO3ZxaSDdhVNnj578OgjJ0z80ceZAyeUL41ggYIPfBH9c3k90xvwCN5VxwyxfqfytUt
 vuk9RHw6Xtl6qzj77KU3gwB2g+nANN6UREUjvq5FxkUCxXuxFVjJNPQaHGVX3DUtNkFI+76K0uC
 60XNS5yuxy4835qtk0+u0c3g0pxOd4l9QFFxMCdnVSJQYRpLqtOCjhRZlGs82fzewVV2DZ1vM9j
 H5nHeYhfWvHUHSqBm4goZovdWVVJmIkNnf4LoqmgeCcU6gxRrGhu/iD6kD2Bxp6eo53+iO1/n6N
 Pzl3CF9tW7KonvBEgj7N26xhAHwOREnK4XHdiQhhiIFDNQBvmpR2nqYuYdqj0tUk4yAX4spFmW0
 fiiT0PjwbFNOk/gpuUCm+Qd+GwsQiPnI4lVcGODIBzgVpylBT57BBMqSTwdz9AFQhnGaLclj
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685aa09c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=jdsnN0qd_4ChqkIFV8EA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: X_4IXeAcKDJSEfjXt-QMIRLTZ0iUwMOL
X-Proofpoint-ORIG-GUID: X_4IXeAcKDJSEfjXt-QMIRLTZ0iUwMOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=927 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240109

On 6/24/25 4:13 AM, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> In preparation to enabling QSEECOM for the platforms rather than
> individual machines provide a mechanism for the user to override default
> selection. Allow users to use qcom_scm.qseecom modparam.
> 
> Setting it to 'force' will enable QSEECOM even if it disabled or not
> handled by the allowlist.
> 
> Setting it to 'off' will forcibly disable the QSEECOM interface,
> allowing incompatible machines to function.
> 
> Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> variables read-only.
> 
> All other values mean 'auto', trusting the allowlist in the module.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

