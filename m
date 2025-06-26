Return-Path: <linux-efi+bounces-4006-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF3AE9C2D
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 13:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D13A9943
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8049275110;
	Thu, 26 Jun 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gps6Mmm+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAC275100
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936109; cv=none; b=nf2+bJ6gtLDNmX3JMOcWIMd2fQan7ih/iTbkzVfOi53ROMpYkxJG6/xqp4UCCTJAhJooXZm13vRrgx0v9t+YM+VriurgqIxtp4NMin3qfYmXIR/QEDGdA5pYC3t1CQJ55zH9jF8es1LAGUubICSqHLq2KU8AM2Ro5cCPNEx9gKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936109; c=relaxed/simple;
	bh=tgDbUMq0bPViDmaVEOWRC3V0sWB1g3V6Suh5uci4jrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUNERjulTSSyx45mFstaE0PXfYHUbma1+pCgCnTArlb5SZqD/XgMU58SZOZBzPz1p/lsQuvD8Fs3TdYyXPjYwh4WEB6gKp7Y8dfSUAYwhEVXmhK4dNVfF/DPQj3Qrs0h5xwkT+RvHlO9VnUqPJ1cTYZcJVvFjddYdKaA7eUj+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gps6Mmm+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9lY8q014546
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NDO94FYMHnaHttKs7F20hKoE
	AFJH2zviQvqSiK66GDU=; b=gps6Mmm+xm+3TP0gdVGy1vO8M37A+AbGqGkeRzJ0
	AAOyeDRsWf/Pc3DWZDFglCrDwpvJ2HSuEWvQa6GztPba/aLqrl3IoaENyi22BcV/
	Zrb7dBXhGulA8JFiSK4xfD5Ym2GUluQvy6UpmWFlQDiZWnY1CN/uvZNTecnXH//P
	FrVUod3s/9ndkKhgLWSF9YRwlDf0qp9RpHxJqa0N8eA2ApdMiCdxof1FceJpEt3F
	4Wyzs9DX/AYtYSKIRBd3qWRHuKk+UTsWja31s7iEGLuxTpeaZ+LU+ZuTN0W5xWSP
	Jx/8FGFzcCj7OwZujLu/5txJuEM/pvuO/vPg/nx5/3MFvQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgk2q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:08:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5f3b8b1a1so120729885a.3
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 04:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750936106; x=1751540906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDO94FYMHnaHttKs7F20hKoEAFJH2zviQvqSiK66GDU=;
        b=lxEM/K3b4MINoBxEW4GH1lWo7j9bZ7yWvdoNhnhgXVwdE3j9sR9np4cVHGd0ZH4MQl
         QA3lovpfvWSE2gKit9zCg+O0qj6Wj3qUTPGadd5lXOIZt5EUQAqMWeSJ8w83+CIw6gs5
         FfynXD87vJBpmabPbdv2H9xsTQWp5JJx67A+PkVxToCwHOu2AvE8LcCTID0t39MCQZxU
         W88pYWET4hvtWd21Qe5pa4LTWPTkFNYYOMVlLRfgAadyn8+UjcTcCeiz2gyedbPTWqKg
         hlMLbAG2Yx0kOPUKiLCNAn20SHOlaTgbVHxsYP0zm5HUgAq7O4y8spE9xOAxlbqWTShP
         5n+w==
X-Forwarded-Encrypted: i=1; AJvYcCX3I/1CluWRXWWqfmtfqaKd9+DhMlASBzsCNLOrJQ4ICfLS98EDflRvwG0N9Szkz7aINvDmUCDZGk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6W71x4yWFPXQ67jplP1IXBUmWj7VVJDX9BHBURkD4ouhvO/7
	2/TeJ03Bj8vIY0LOzhjqlAni7sjblmlFSF+pKRPFG6V1O/9chnKYQo6dwXuBIjpTdhqAfJbMGLq
	UtCQFLuwBzDRTwRayu4bUd3bD0VAmgxE4QtmlKX2O1dnmOZ/YeyUM47yGc0yXfZ4=
X-Gm-Gg: ASbGncvMMMScmpJu8T6IQ1vPn6cYUUgLe8AvF+FB8Zzzv1RjwydcnYBk85+0lUnN6tG
	VdzfVrr71+LJ+pvWPX2CsRpg2q8CpBzsDuPosk3mQux1c3BzdkRBpBblAHrronZhZsCUz6d19WZ
	ge4ze6mnj6LB2X6BUN5BgxDnbO/aDqdSX/OEOHy2ddm+nF3RCLsinZKY+slcETF6YbM6nX+3hld
	E1pWL1j3REkFxRU9HyBqDB/6LEef+qFBQPjLiJ+22aefVB6TmdwzL97gJiUsJlxN8K0jeNXK3hn
	PAIPd3xWY/toQtWkqpQUqtAAxGice/hWnVZ0r9CSAIdfL13eI1jR0nPIDTRLdoIsc9bgu+iqW8M
	g8aYVkG/gCmlxc+ZD/zcQrgt9Wlnp80H0ZUs=
X-Received: by 2002:a05:620a:1a0d:b0:7d3:f9a0:2c10 with SMTP id af79cd13be357-7d42976ae51mr772803285a.57.1750936106381;
        Thu, 26 Jun 2025 04:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYQ7jiX3CY9CqgVQJOm8mOTCxYPh5cLR7q4CRfPMz1xEcvXyNgrncOwmwhAndCAILJnT25Hw==
X-Received: by 2002:a05:620a:1a0d:b0:7d3:f9a0:2c10 with SMTP id af79cd13be357-7d42976ae51mr772798985a.57.1750936105882;
        Thu, 26 Jun 2025 04:08:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e414444esm2545086e87.29.2025.06.26.04.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 04:08:25 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:08:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Message-ID: <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
X-Proofpoint-ORIG-GUID: UbmtSCe98-Gs87QNGNlpvHK1qQMV5MmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5MyBTYWx0ZWRfX16dnmeTVh/HV
 SMGOPUArgG4YUYUpzr5T0gDaADI3QtX/Kdbcq+wmWWee/1q5o5BVMwOFc+q/jlGCRb8QHqc1eqF
 22hpr2dhRO03Bx8c0PYRIpgGJHHhLohiDTxzM4bZhGPTVLbi0IO4ZDyOrZiZz067s+p5H9Wa/Qa
 U+yp8SAEv2W28YaKtGdDUhMQtoBxLI4vBnKdqUGrKBVCvcUgLj72sA+5C3S9/bIkkHIwIhx7Ba5
 6TfLvwW6gjFjgsOwqM3Fe/WBeJFZ6WlLArezebKnDVFVxrgOqBmttQlOehz+PQ1tpI+noXc9aJs
 nPzlP77FICWEZ53HZCMNFYi+yjCnDR/UBqNlH11Sbt4tADKmEOT8IOH60NBrk0RQP0J3D+P4iOZ
 i+co800/dDVpOf6HKNqoddrgo9GmIZdfcga0aplzms6YG1XGco5oCCPQNFhsy/aMCNMzujLq
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685d2a2b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=H1AuHuLdujuPDguO8vQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UbmtSCe98-Gs87QNGNlpvHK1qQMV5MmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260093

On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> On Wed, Jun 25, 2025 at 01:53:25AM +0300, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > In preparation to enabling QSEECOM for the platforms rather than
> > individual machines provide a mechanism for the user to override default
> > selection. Allow users to use qcom_scm.qseecom modparam.
> > 
> > Setting it to 'force' will enable QSEECOM even if it disabled or not
> > handled by the allowlist.
> > 
> > Setting it to 'off' will forcibly disable the QSEECOM interface,
> > allowing incompatible machines to function.
> > 
> > Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> > variables read-only.
> > 
> > All other values mean 'auto', trusting the allowlist in the module.
> 
> I don't see the need for this. The kernel should just provide sensible
> defaults.

It does provide _defaults_. However with the next commit we mass-enable
QSEECOM for SoC families, which includes untested WoA devices. If the
user observes a misbehaviour of the UEFI vars or any other
QSEECOM-related driver on those platforms, it is much easier to let
users test and workaround UEFI misbehaviour.

I can probably add an explicit message that if the modparam is used, it
must be reported to linux-arm-msm@.

> 
> Johan

-- 
With best wishes
Dmitry

