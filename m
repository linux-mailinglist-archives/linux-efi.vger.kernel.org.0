Return-Path: <linux-efi+bounces-4008-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D64AE9C3C
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A81887B26
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF813274FF4;
	Thu, 26 Jun 2025 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cGjtip2j"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718C259C9C
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936245; cv=none; b=JhmVnVTtxDB7B+/6ItNAwl0hqQR2ATdwacqnZuat+asOg/yXEvFp5aUJUji9pUoymt8c4vcg3LW2CrVkaGW/4q7YUSbjOENTHWaFrFn4vM9id72mxZsXAfbc3VZhExJv9xRcyzZpRe0RH/TVDX0L/MDvE/JNNe3oIGYN76KOOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936245; c=relaxed/simple;
	bh=+Nh7arEhb4mdiIAA47zJAjhf1JoxtTqPoXIZGzCdPRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtHwJ/51+5n4snCUJ9PRf3aERJ4mwaPfZj4oujJZzx6juLUBJDz74fw5mx5gYWRKV1bYs3rPvLABduY8r6uAI0+K/ZHkX4pIi7tPXVlCZXCJYQXBOuUPYFWDCXaRO7q5gkoLVYjpWfAGkIPFPdORJ1y8P7rPqPu2fgr0+QjF0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cGjtip2j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9sXP1015336
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cYqt5KyHbC7L0Vd38ScC2cJZ
	2gNgSimq/dQgr20ruzc=; b=cGjtip2j6+BIXEt74Q7TzPgDNrkfy5s8AZt5O+x4
	XFVjrtqgX4tg8caenZ9UvSKQ9q5rvIEPXEJsebV4dNGllfttOXMEwgM9xBaq2q1C
	Ce+VIv3+o1XziKum5pq9pnyIA7xIAc2G5SBic0KPxXXuQ118IfIdQau3quJTreC5
	AxB/4dZKwK7tlMsZM7jZFASu2Gt2vJdIL3v5nC6SN36Uj6KMICjhYlZOi+WfVjKB
	2MLER2Nf4nWCCwJ/mo4zUSMT52oJwHx+5RfNtrORP1C0U+fIH7xfedWxiuB6eKZu
	yglROC0YOp9sdnFqVXCaEzxjgcgjig7cBaqblsUV/vTzbQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fcucv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:10:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d0aa9cdecdso66381785a.3
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 04:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750936242; x=1751541042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYqt5KyHbC7L0Vd38ScC2cJZ2gNgSimq/dQgr20ruzc=;
        b=RxAhIMkrmx+EFKE7qHcIOexXN/WDApBOXlZapAcA6Jnj/GNxTN8aNjrIzmjQrz4H+S
         lkbjqtCmlwvrZ9DNKFHHvlYCMBYaiVP9X85jUUdaMhM7ZjW5glx8lSZEBgEZnZbWq6fl
         kE4XufP/R3Ee5knoYadHHzut9jim5NOyG7G9x1oJxEELfgIydVTSrcnZpFURJfs9+idu
         na/P0HB6MrdJ7SCMxNu9dDYc6e0IcM5X0Z5Cn9v3MxfzFC3gUe4TjF3iax78X9Tw+Vai
         9WDRdmcaYd9UfE/IX5FSlU1gxFJupgf2GGVnDv6Rg7++Zxbx9LZ2BoYzSfWXzo1fNZRM
         Jrkw==
X-Forwarded-Encrypted: i=1; AJvYcCUseKILwf2hIlN/5n0+NofuZX9UHMI09WqwLc3vka61q0COo8SdH7E6/c7C0FVKfJxhqoUSzhpIOQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrejLOJGcAotv0Z+kcDCTzViJVWBKDAcrgkkMUTAdrXSNGk4g
	FE9UNX7y5EyokJv31jqgRdiJ+valEe6cqz85eZU85nzPxR+6YhSpux31hQKrduQoQ9JCI9wa7qA
	ZzfIUhRzB8BEs7t1+Lo4smcCKSUmASJ48TtHxFc9vvxcatWXLBJ9h/lF9WbbT7Ho=
X-Gm-Gg: ASbGncuYTNg6WCVkj7oTGkD7OVtfubFKdqgE6ydLqzbmbzs5YAhLG3aPjrpNhwLU1QF
	GVqxHI6Dfz29UHbsSpdp6MFnP2FrPyFlYhkEIr8vZGMLguzJNKjmmGYI6ZJYkrUTU1X+nb3tjlx
	RjSbVe3YTqIeHl+QOYjXRanHIk9tCm75g5U7cXJW9A9GsdoJ7sO0IZNmZ1sa55/1cOjNkSYyy2i
	7MdPX5oJqrKnU5nxd4AmFjcQ+i5E3Ou2Gc6rfA+1aa1kmYdhhQruYbQW7hJIi7EutBZJvCKpa3r
	pkp22puKKBUnPmX2k5a4iExsLt3IsK6tE3QTLdMPkv56hrPVy2ohtgnF7JRJAkIoeCUa1Kgrpfp
	SmuElSN6njJ+Ax0eFq49AFBWhPVDER02nVXw=
X-Received: by 2002:a05:620a:7083:b0:7d3:ba53:d88c with SMTP id af79cd13be357-7d42978f2c2mr996162485a.30.1750936242246;
        Thu, 26 Jun 2025 04:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjtAiIEi52PqDdVHz1fI8lluW9aTCSB2ftm6y/pWoW4VAWz4SzJ2hSwGJSK/pOX00PIVi2pQ==
X-Received: by 2002:a05:620a:7083:b0:7d3:ba53:d88c with SMTP id af79cd13be357-7d42978f2c2mr996157985a.30.1750936241770;
        Thu, 26 Jun 2025 04:10:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e414beb2sm2535941e87.53.2025.06.26.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 04:10:40 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:10:39 +0300
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 8/8] arm64: dts: qcom: sdm850-lenovo-yoga-c630: fix
 RTC offset info
Message-ID: <xddgggbyt7dyy6a75dup7dgt6fxy27sopkv6febckstcpamv72@sfbul63yeex5>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-8-aacca9306cee@oss.qualcomm.com>
 <aF0eEWK8d-l1Mxma@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0eEWK8d-l1Mxma@hovoldconsulting.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5MyBTYWx0ZWRfXzuEWpDcXwfXZ
 WHidivLIG0WmG9L1Ok673ex9o4uWU3YB6NOg8zNLY7BznVnXs/tSJ07Sg/XcVFXoezITayjPyG7
 9ak/DQwAAzOaBuFO3XbSxU86KVrtngu7cYDYZ41stNU5L0GWRIqgdbfrbLLuz8j3S68RRAYYtKK
 3BCuELbY9GXSovOEnDlVzwhZEgiJX2c19ZLQp2wNEIByKvYKFBf5mABjPXH6+kFgsJjsLXVN7vm
 bEaawPlWkRjxGObTMJEiWdZUi8TvZmPFh1mGRZjTjC75B7uMoQC7bida58osU0lItGdCNwh3bDO
 mtbe2/W80q6a9EsYJooWwS6Xtr9xtgj9xxYhzHNSsuoSbEZhmSZ/ey+9fSu6lXC4676pMwGND8I
 6/5DtgNbN/Q2kwNeKAr26PIXfzd/H5u9HEeozudfp7pOVb5AkcspprwRCY1QTL+sQw8wmxWA
X-Proofpoint-ORIG-GUID: g6UTuixwzeQ-vzsiXBcouEv5SEhdvJn0
X-Proofpoint-GUID: g6UTuixwzeQ-vzsiXBcouEv5SEhdvJn0
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685d2ab3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=rtKsz54fpWh7oidnevsA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=963
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260093

On Thu, Jun 26, 2025 at 12:16:49PM +0200, Johan Hovold wrote:
> On Wed, Jun 25, 2025 at 01:53:27AM +0300, Dmitry Baryshkov wrote:
> > Lenovo Yoga C630 as most of the other WoA devices stores RTC offset in
> > the UEFI variable. Add corresponding property to the RTC device in order
> > to make RTC driver wait for UEFI variables to become available and then
> > read offset value from the corresponding variable.
> 
> This is not a fix so please drop that word from Subject.

ack

> 
> I'd also expect you to mention that the RTC would be heavily crippled on
> this machine as the efi variables cannot be updated.

ack

> 
> Is there even a UEFI setup setting for this so that users that have
> blown away Windows can ever set the time (which may become totally off
> due to drift)?

There is a UEFI setup UI.

> I'm still not convinced that this is something we want, especially since
> you could have a fully functional RTC by providing an SDAM offset
> instead like we do on the sc8280xp CRD.

No, I don't want to go that way.

-- 
With best wishes
Dmitry

