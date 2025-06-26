Return-Path: <linux-efi+bounces-4030-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702E4AEAAD4
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 01:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085773AA861
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60A2264AE;
	Thu, 26 Jun 2025 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSSzIlaz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F772153EA
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981689; cv=none; b=hOvtLut/5cgd6wis8FS7tzXYQap4BMNMAOBXDVKFiA+/QZ4zdW5NH1fm4aBXKDBOhNagXEEuwr6koBOYNPNPax8ExoDd0MYZypmBuxVe0LOC1d55JMot/17UTDB1ZD6ALEHkjfQfvhKyIG5+2UfoQcjLOE5XZOTVEGu0/38P6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981689; c=relaxed/simple;
	bh=GJeEEk2k+9QDO4GRwoK8rdidT7Hui7V7SG1hw9vaPec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihJxbhIisQiTG9YAw7g2oMqQpycEvhldZWdkD3r9i98eJoCgWYfDiQd6G28ai9AarX/TxG80UXpht+tDr1M/f1/V9VD25nFgSmhEXexnF5up80NgnhVNa6JAooiuQXTwRtr8pVxvmIM4uLQZxoZbTaeAiSwMTuf1S4EwO6vrfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZSSzIlaz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QHIOt6002567
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Jcqp3+hst16YWzvGdkkJ7rEp
	8MCwqlwyZH1HL9EQbcw=; b=ZSSzIlazO7dpLTO4uSjFpg7YD4GcFkAhKwAyuZIH
	8WrWmXgW1TLFGI4nEwZUHc54LLaU6TRdXObY+7C3k7VpXGVcsDjm4TfpKOGzjI5n
	YZyccFObOU3rlxP5ibsv71XourvsqCTEB5WYPJuxk0Zk67F8Yge2LmfqBjdbMHE3
	gC76Jz66379TiHtY7jhr/95qXos7HvU24jw6ofabRfQ1iSL+EKcPm9G6V7MiVmZZ
	v1xFih6iEd0KTnl3ri4VumAXXRi7AKinj5MFt5s+2fyW9stn1YEwZ6+MF7VFJKiG
	/CbuT0b1ZVil5KY4ggIWZsIOgiHM7HPKmFKi68rI/eIvKg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmxmev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:48:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7ceb5b5140eso218287585a.2
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 16:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750981686; x=1751586486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcqp3+hst16YWzvGdkkJ7rEp8MCwqlwyZH1HL9EQbcw=;
        b=QKEKiGOGJSk5A7/CNYA7FnEU0CfzuDpwwBw27Ff7eKjp8ZQUtIH5BGNyEJNMIpk+1x
         Q+JOnFSUD/JVuUNxNSJgm8yVl4wz+701KZ/WjXwWw+nSyquvUq9hw5q7sG/HY2SgBJZ9
         3XdJ8kVxkvcY5lb8zF/wH8S3p/cxbTbRN6GjK8mc+NuO9wqsWL4+MNTJUEWJW/usXNkN
         o+jd/V8RKwzmb9+xH23/TCgSZaWpxgJPyFc+MesRSpAyTF6urgDrTm5XHrsh8u9HL+KN
         0VbANNNpG+tSwJ9R3rOREHg523qaMSv/GWdo8J2o02B7ZogrvrAiqZMezfuJLyFc5B7l
         F5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHe8cUIm/vutm6jF6SS+SuciJjva1DdCpUH5HKhiPucRYPWvpb2EsP73jB3ErMEy3GHWwIdKyeJ+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0Tx808eFFVgylZlb+//PqdXF2qSlfKlPgC3zN4MLnmsi0Jdd
	LXiMscTgUg02huBoDP0J6cxJ+OB+guY76pM/PHS2C0pPFWGzbmh6WDE2HcxQQowS/OpV/WXy2d4
	vbkzniThq7tZYFpcFh70aS5TzKXvPSfwm9p2zRPUrtm5eqY9UuFZZK9T+4SmU2mw=
X-Gm-Gg: ASbGnctqANErJPzZomdZfk7kNpeNxz6WSP8EdR3nmeNVqsy40evGWUjSFxu6syJgh51
	oQXPO4gEuNDRnVS8ZvffEVyqVPwKDhwCDtct6RAzLvn7CF+MkhDkCGpyURaqQZm113jF3bdG1+u
	zQIPXaH2b1uQOfpH2VtMAmTFGelqgzrjlv6yKzaIKvtkvsL111t1Yo6hFrZ23/HRTeaw05ah3qJ
	c3kwn10QDJQcq3wfbwxSbT+7Nh8HSl5GArymGTrLujMr1OQqCS6Rt4EZEI5VNRZ2IlH2pXXfCFR
	AjJyukhBqkyv0T8eeVlfF0Cgjzj4GF77eUXTbnk1EwGvVy+jt2sBt3rqF/IFlMsnRkHwE4xk6Tr
	wnj0pzUORcXXv9zMnZ/fYxHYccnk/bi8M+nM=
X-Received: by 2002:a05:620a:708a:b0:7ca:f2cf:eb8b with SMTP id af79cd13be357-7d443950f18mr219893785a.34.1750981685897;
        Thu, 26 Jun 2025 16:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8LImz54AwYU8qJ3uD+qw0ctbfw33heYi7sSbh/STbsvQec9M5PenlZbd9yKarCy9GjAAvFQ==
X-Received: by 2002:a05:620a:708a:b0:7ca:f2cf:eb8b with SMTP id af79cd13be357-7d443950f18mr219891785a.34.1750981685435;
        Thu, 26 Jun 2025 16:48:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550be2a0bfsm126329e87.153.2025.06.26.16.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:48:04 -0700 (PDT)
Date: Fri, 27 Jun 2025 02:48:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP
 CRD
Message-ID: <wqmnh7x7pi3tg5ascnfmy7lzjbe4wbmcf4ycjndtovbxkxajsf@ghayhqaixhnj>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
 <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
X-Proofpoint-GUID: B9txs6gNjTH2OaiLidBf4s_f8bbpEEjN
X-Proofpoint-ORIG-GUID: B9txs6gNjTH2OaiLidBf4s_f8bbpEEjN
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685ddc37 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=Xm4G249AS8QJ8kFCN1QA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwNCBTYWx0ZWRfXxP+YFYbV65Ac
 JJ1aCJEcJqCtoakh0cWN3WWGmTU7tz1UhGJTqymtcydDKhMLwy8vrgA6T6HFHZoLU8bA71Nx48D
 8Ugdwl5dVDHa8sloUi0oJXB48EkWhoy+/iX8Al7rg2bNmf/obZ8rv0/9+LEw8n606GIhYY0sw17
 tL+LgsH2PZyWJiN/FB6mcD5lTheDkxPt5Mkb6rnIhvZVRnhXTd1NVl9arFAFxYFye6CltTmboUm
 0+4UcEV/mdrhAxvzVFQa0jPN0tmoi60afdTsXEOeV+ibpD/A2zMkhbnrh2E60E7Z2wmSXVVrOnh
 opGX+dOfPoUkBuAxg2KtGmGrijAqF9TT7+bAyDL7ao6UGvMerX7klfojoASGgh8q/ra0mxQMJcG
 VfRdxuo0JZNfrfx+rvAFpdI7CL4QgpzENgiu5+dPPN7lhejXRUUaHa5MRlsffVsKsV6nvZTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260204

On Fri, Jun 27, 2025 at 01:34:56AM +0200, Konrad Dybcio wrote:
> On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:
> > As reported by Johan, this platform also doesn't currently support
> > updating of the UEFI variables. In preparation to reworking match list
> > for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
> > variables.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index dbb77c3f69ddaa931e7faa73911207a83634bda1..27ef2497089e11b5a902d949de2e16b7443a2ca4 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -2005,6 +2005,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
> >  	{ .compatible = "microsoft,romulus13", },
> >  	{ .compatible = "microsoft,romulus15", },
> >  	{ .compatible = "qcom,sc8180x-primus" },
> > +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> 
> R/W works for me (tm).. the META version may be (inconclusive) 2605

I'd let you sort this out with Johan. He wrote that variables didn't
persist across reboots.

> 
> Konrad

-- 
With best wishes
Dmitry

