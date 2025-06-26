Return-Path: <linux-efi+bounces-4028-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6AAEAAAB
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 01:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9201C408E7
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D52253EE;
	Thu, 26 Jun 2025 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1yy9XhS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BBD222575
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980814; cv=none; b=t/6eSluebnEfPgSbqa9TXCSf1xWehEZHSnCZQ7M6fdbnUdSWlpmvOAWOn1mxQllEwIMpYtus0MtWcN5JqLjMKd1TqXwHwC+fTsZ9DeTIcHcePnjHlkPOtazFDeJtC/IpaUzP8v84BMnOxv0MZspd2OQ1UETJzPe4ZO6wgl4L42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980814; c=relaxed/simple;
	bh=9DRHyKEn3LgdNudaN2dAIvpVac1tRIy6t8Yc8Bw5peA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUeXoRBM6o9MWXqcRteJkzhzARhcA8FpJRyCM0JC+8mR0u0y6/sLhGrqMJARdAdm5/rZ3ih8+f/oI/oB5+smaeYY/vtiAtmSFJ3pbXv8Hphk+F7Ts0GvRUFQMCgc5CWWDz3sDav4MjAm/1dyPQmz/LcoVAzvbN8c1lvUeV8ocGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1yy9XhS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QJa4We029548
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p2pcURoybL3Y8aXTxu2NYraS
	kKyVcrAYks/QDQsGU1k=; b=l1yy9XhSO/vVbL3e3265u9OwW8VX+jhvZgqiDZ/V
	gpfOu//TDT0C1ZxgewWKyfN/LxW3dbLHU+CVG3syHehitFaqGSCnOGX9xYmyBCuw
	6wOfBeSWoyMH8djKRVtN/ELUHTysoKVDeBl41X14/mC7pztTX4dQC44vjLFe2O5h
	6X452Nt4S6FqEDVvnAnHAZLGlmwr7yqK6RW/fgPaKL3aKvirlfrF0gtRdwcc2SXZ
	lU2ZweOrtb9Fp/YrfWOor1/L4x3fx7hOg6XPTrzl8SykgmwyvY8Gpc+RJVUTDqBx
	KrDppIreTE7tQ/ZtSThVyWcySibZeA6A2195E9+uB6edkw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4x4mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:33:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d0981315c8so141601485a.0
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 16:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750980810; x=1751585610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2pcURoybL3Y8aXTxu2NYraSkKyVcrAYks/QDQsGU1k=;
        b=mvFs0heFgHPbMM/pFtNzVwYwlX6Ad5HnUXIk+KjmjJvtipNOl2bW+jVsf1411lhDQH
         hR5aqaKfJFR3/jbCl4zf+leh0F/gwBXYsnGjdbQFIdP1wubcCGN3eqKed6lN9UqMGp84
         KVbGC3RHS+E4skdimILb5kJ9to3rbkET49PouTazxOo8+4GAekWe0fXGR/BF43SWXTPr
         q6JUUC6vbKPRjFZsM5p0Mj5x5rhwB99Jg62srYtHka4b0VLeJ4VkS0iQ4SGgP3whl4a1
         K4B1tWXPq1VIGqbN63YvFCo4J0XhXNm7WZQ3Si3k/Fk73FaQF4nzU7tIOPu2VXPvQv8t
         aa4w==
X-Forwarded-Encrypted: i=1; AJvYcCW4nanGNZGs/Chrrz0YmuGTdIP8HktszpWupGzXhPbX0Zb2n1RKpxIoH29MSdLWdPhjvCGPpusabWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9znJStIgP2Oso+iDMtjkIyNhvKTzbys18ZOdTGU+NBUrL7NJ
	VRp8hqfKcEoiz2JvPHjbcSqDFoS/YFSTLSXrR/opQWxY+78aNBnlumlUH5tYP72/0fxWENOzr86
	j931QbvXwxAwZaYTSUpczqN/SxbqSTf78c1nPeqeNU2wkhhKDesIET8ZSLww0ENM=
X-Gm-Gg: ASbGnctXfwgPpMV6LdytRwJ1x45zxtow1qURfwgexwrDFjkNOztFTgoNY0LilsKNX6n
	DZfaYA/s2MJlN6pCHGzCpcceGmQmmP2FX4hE3y/RcbzqjF2kDX/lvwTMs82KRlxz8A/2dRA7yNm
	lJyHttMbUxAfiB+mQC/vgzjxR31KfZRT/HHFLLY2YwcFQRyafcBVHCeE2B9Sm8c0m/EiyAGVunj
	8+Ix9mu8vBThGnOk3l4jTtY20CJ0QbAzipFGflXuSyfe6IroC4dcQKqXRGsQYQuIfR7i9HJ2srP
	8lXlz+nKiKOZczjQYDTvTCc8qckcn/1OcJK6ldTVVgLf6zHEw54XkisINzFdBX4ttUwa4m6PqFQ
	9JAB57B1QsqpXzw8Dh9FEocwqWd5G7zz5dDw=
X-Received: by 2002:a05:620a:27c1:b0:7d4:3bf1:b1f0 with SMTP id af79cd13be357-7d44398e3e1mr233339185a.18.1750980810048;
        Thu, 26 Jun 2025 16:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIbx430OqgmF+GQnggSARqLbLWDAsCCU6kWI1oFpMQKp6uZB7h+OTCcp2g2ALy/bF+tlAVHw==
X-Received: by 2002:a05:620a:27c1:b0:7d4:3bf1:b1f0 with SMTP id af79cd13be357-7d44398e3e1mr233335285a.18.1750980809603;
        Thu, 26 Jun 2025 16:33:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2b95acsm195077e87.115.2025.06.26.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:33:28 -0700 (PDT)
Date: Fri, 27 Jun 2025 02:33:27 +0300
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
Message-ID: <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF1EDMsw1KQTlteX@hovoldconsulting.com>
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685dd8cb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=NVsCH3EOgwMYIqYMOGoA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EKQ1tzp-irt02ow7-9nZiGxaS6Br8st1
X-Proofpoint-ORIG-GUID: EKQ1tzp-irt02ow7-9nZiGxaS6Br8st1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMiBTYWx0ZWRfXzV3hLQNtKQCO
 ha0we997GpiVEFD3BExOfVkPptnlYyQh70D4eMdLnEBqDrg8PUcf1ugNuk0zb4xI9NDMY/ockic
 oINtyGnv3LuhftMsxaoEAJ8k9RXToNLJXFtp01zCwm9jRPEEFVbczPGzCLL1OFwq47Cjv5Dkwxr
 nW7dJcUqLBh2Pgdu1Awa0uGpngRsYZhBx1zVqNafbAxWDpM1KYX7TueqksnnRDiD8h4wvvTQCb9
 NnB+vIaJ6Cecf5x2Xd9p4mcocF1r8XedIkDh6XkpPBc9F2TEHKyYH9Uh8wzCvHIJaxNF+pn662c
 6CLJNBqmuccm6fLg2BB7IbEDt+5f4px53mVWn6NaFxw12iU6LTdW0CRxeNLn9/JCW2QWEhlA2ji
 bgU9t+rKkccgQs/qDIfgmowWWYTsFED1uHq2Tv6Yems2rMDKUIUWZfdpC2R+AtPL9/KQKrOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260202

On Thu, Jun 26, 2025 at 02:58:52PM +0200, Johan Hovold wrote:
> On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> > > On Wed, Jun 25, 2025 at 01:53:25AM +0300, Dmitry Baryshkov wrote:
> > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > 
> > > > In preparation to enabling QSEECOM for the platforms rather than
> > > > individual machines provide a mechanism for the user to override default
> > > > selection. Allow users to use qcom_scm.qseecom modparam.
> > > > 
> > > > Setting it to 'force' will enable QSEECOM even if it disabled or not
> > > > handled by the allowlist.
> > > > 
> > > > Setting it to 'off' will forcibly disable the QSEECOM interface,
> > > > allowing incompatible machines to function.
> > > > 
> > > > Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> > > > variables read-only.
> > > > 
> > > > All other values mean 'auto', trusting the allowlist in the module.
> > > 
> > > I don't see the need for this. The kernel should just provide sensible
> > > defaults.
> > 
> > It does provide _defaults_. However with the next commit we mass-enable
> > QSEECOM for SoC families, which includes untested WoA devices. If the
> > user observes a misbehaviour of the UEFI vars or any other
> > QSEECOM-related driver on those platforms, it is much easier to let
> > users test and workaround UEFI misbehaviour.
> 
> You basically know by now which machines supports qseecom and which do
> not, right (e.g. UFS storage means non-persistent EFI vars)?
> 
> And it's a pretty bad user experience to have people trying to write
> efivariables when setting up a machine and then spend hours trying to
> debug why they don't persist after a reboot.
> 
> I don't think that's fair to users.

So, is it a user or a developer, trying to port Linux to a new hardware?
Also, R/O implementation makes it obvious, that the variables do not
persist.

> 
> Let whoever brings up a new machine figure this out. It's just one
> entry, no scaling issues, and we get accurate information (unless
> Qualcomm, who sits on the documentation, is willing to provide it
> upfront).

And that's not really scallable. All other parts of a particular device
are described by the DT only (that's especially true on the PMIC GLINK
machines). If we are to support new laptop in e.g. distro kernel, we
need to provide a DT... and a patch for qcom-scm driver. I'd very much
prefer to do it other way around: provide a DT and patch qcom-scm if the
laptop is any way different from other laptops. E.g. we know that all
X1Elite laptops support R/W EFI variables. Except for X1-CRD, which
deserves an entry in the driver.

-- 
With best wishes
Dmitry

