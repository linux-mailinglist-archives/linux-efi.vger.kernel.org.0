Return-Path: <linux-efi+bounces-6147-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDLgCZPykmlA0QEAu9opvQ
	(envelope-from <linux-efi+bounces-6147-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 11:33:55 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A73B142618
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 11:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4FF3011117
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E52ED870;
	Mon, 16 Feb 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aNWm/E1U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrBioxM0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECB26AA91
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238029; cv=none; b=ZxUQe8jVjLZBHk9ccVh64y9VRNDtNfP37H/L7YBXLwQYaoviF9WwiUeSNg4rqT+02tyvpiomTcWfqiNt9sGoTHFDMfjszd4U8lh+pGwk8GHF0lkNSz2/yYowFWpC2e4tQPT8URmJA67mEtWcQ2Ih0iWUXKtHENCQJlrvjwYLW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238029; c=relaxed/simple;
	bh=HVSz5TtFblygHpa7Y8vajSh/l+XHs5DyC8PJE5dVsD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCjbUiYJzSfnADzYcaEeg3RejJdJhutt1qsrUgEDM/OaES+xecfguSDIyBUBiGbCVrW6gQtmOZTK35xS2PeZ10zfRF1oXbf0VNIF2DEr18VhoYJqbvjyRY/MC0bMp+9JX+5MCgmyni48EHurzIvQIcMWKAShuSAJYg80A4f1NI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aNWm/E1U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrBioxM0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FMm61S1366607
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 10:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7qT3PYfzNPVNMJsGBk/5dM82E1f/rJKDYQvjgXohlQc=; b=aNWm/E1UUw6LaAbp
	VaUBJ05xZeaBUDYlnGsWyioTIxpCTGrBq6BRS+F9v0blGCpVSKwkXkZ5dz7aG6r6
	jFn/FlYyeXbaLSeX/Az+KvppEifw/QNCr16JvsEUzFJisqhudSAwvJHTYD+DF9hk
	Nk+Fj2gnY9q8E9wXTsGTSWFcV/8nbAxlueW5EakVk0cl/aJnqICuEtY150uPs2HC
	YKYsOPpR+Iziuob8JSpHrLwp0RGBK/S9uGSLoEoMlKgE4UyOh3tMa5QURgiUG7EN
	kwD/ZnCwZ6nr/pZ89gApkdaSZW1JqunIkX3T8qkkC4HbK6jWfrp9uAOOiMKE2Tvx
	8P1aXg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cajb8v3c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 10:33:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70e610242so1855063985a.2
        for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 02:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771238026; x=1771842826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7qT3PYfzNPVNMJsGBk/5dM82E1f/rJKDYQvjgXohlQc=;
        b=FrBioxM0yYZ3mw6mBr921Hf6W2GnjNDsDYTz4l10EY0L0IK/Kkq2q/BEr4qpfqJySy
         woe80iKdYWftrMy5/m+smJ8SeG3oJvS/AczbyPrDSdU0uPfBp1GwsD98SthPYBHX6snZ
         9hYkb8Wy+ivzn7aaqk2cfRyfrIGDYxYgWMdopbOL8CizydHyFcjFH5laZAxBmBLo7UL/
         Vh1/dNXLaDlLST63KfhWCyCKpJSeBGhBacRjGaRwAh94GYhKuo++4KiD6lqdD159k/Rg
         N86XptkSbFoozuTxAUrLx08xCv1aIyuSd9bthI2fdLHFOS/7jdGm1JJQuBgGTPhLyPw6
         ZEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771238026; x=1771842826;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qT3PYfzNPVNMJsGBk/5dM82E1f/rJKDYQvjgXohlQc=;
        b=ZLEQRx2VZ8OesiGMOdQYdNjXTTpTbh/6KJhcJZO/qmbt+8HwS81Asn9Xw8XVBue11w
         NC15NQXXBJOywZKuCiMz05iHZhxvhPjdMHX2FrChl0VO2+ZlThNzYmYPvZyfDNW3Vj/q
         8LhI+gGIKpP9X6PD8kmFwGcsTiT+E+46aQKDSKDdQ2lvZpnJKdMqgTYoWD3Y+Q57YevZ
         ZiH1bsIncbzmwrsP+BZLGW3c7N1t+YUtw5Fnx8fjvk/UOPKT2EwdOa/JbNQlOW5NwKDg
         FUEUyW/HOUi1KD3iS7oyd1ET1Mpt5bxkOqFYoZqGcVZEOtAc/P4cxOh6ojNYWr+KG5oN
         JT2g==
X-Forwarded-Encrypted: i=1; AJvYcCUGwJO0ILYM4BF3M7ufovwdKnHrSGtAk2SF954sSDPEmxu0Ffmb3v74rnidrWDxSo2Y7I2wnI5p/BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpMbeByw1eobLcmIyX3BoEoaxk7VzuOgRfIgaI86MCK0hACpO
	ivbAVj+QiV5Z9sfzvZN/mcUkpHX6If2KsdUSsIft090XacEuqKYTvvKEuvFl/Qxymo/8FZwZ+Fy
	EXwHz2nim5e8W98uA9dY8IuJESMwk3jbNrhyIBRZa4dkU0+JqFNb+5OCyp/shJtqPgFuP8E8=
X-Gm-Gg: AZuq6aIbgD688VSdGEXgTXOaV3P5IPe432S5Pd0/gXZwt7zsnAR4TZJIktVvpBLwkkK
	7SPr1ujkXriB/+WJQVAKn+sGfvrjwplW519EhSaIh3uE/MJVJgBxfSSi1z5714STmKt9TsrQ7ba
	F89ykFtiz44bQ6Zsb+4L7YuL+Vd1Fsd6FmVVAkYj31sjcqvfJ3FBFvNtELDyE2Dlgxje3/ad9sb
	4FHDjR/x1HiDe69xPrXT6yOL6JNxprBXqnG5Wu2y42lJQ23qgpY+NWpnb87Aagp9QyDQ4zO6HHi
	F/QNixjbQmsmSdzpo+NOGVmtMZMMOkHi6vcrqXm7vbydU5fGG7WsHRIQHlWDSY4HUAeilNsEiV3
	cECbcyxsxBHWjDte/N/E2q4shPPjB8PyQ9BBChihrrU88XJywgw==
X-Received: by 2002:a05:620a:254b:b0:8c7:f62:21c7 with SMTP id af79cd13be357-8cb42281159mr1182792785a.20.1771238026071;
        Mon, 16 Feb 2026 02:33:46 -0800 (PST)
X-Received: by 2002:a05:620a:254b:b0:8c7:f62:21c7 with SMTP id af79cd13be357-8cb42281159mr1182790585a.20.1771238025643;
        Mon, 16 Feb 2026 02:33:45 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm454093795e9.3.2026.02.16.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 02:33:45 -0800 (PST)
Message-ID: <25d66619-23a2-4566-bbc3-83be8eae9d46@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 11:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: stmm: Constify struct efivar_operations
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4OSBTYWx0ZWRfX33mLC7yf1BTT
 4MZ1NZz1p+XNRhPvqS7sa4HT/vwVZ+muksc2RoN0ThTPHQfeEF4yhkYnvkYINa29h5eztoh3+CQ
 wn59UN1yqIfmLBxVqHlUAPzzIbAjLkyBe0pnbQcSDLosoQTa+Hwt9GoNVAP0F8KXpo+sEC0DSVF
 7jdgzuHcb2Uvxc66dtSwvrpJtxxrVbFM0T0439TE6bRchFDnsxU95W5stCLMpnfgcJHZc/AuNxk
 KOLeM2wylZq6gS02IzxTYIuNLXvghPWhSYRohjMW/KZTR1oMepOdQfh/TCyL+5N6oJisVOPaMII
 BFsjqxT/HKDgH0dlmdITorjT8ed1sLyDxjLSHicfo2pJUzwmApu9hezeyP3hdCgze6RpTIWtZ2s
 94q09nw1VkG0I9AxxT8IC8qsfbGu2npAJySrR9tswmn56R4GoQb7S0C/sF31dwxUQuRzcmmVDX9
 0ZUOA8Ou9gdPi4C4LxQ==
X-Proofpoint-ORIG-GUID: Xi9tcMHSDpOEYLFp1UMq0QbGx12czRrA
X-Authority-Analysis: v=2.4 cv=Pe/yRyhd c=1 sm=1 tr=0 ts=6992f28b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=4HEYRM_J1xu74ZP5z-0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Xi9tcMHSDpOEYLFp1UMq0QbGx12czRrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-6147-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A73B142618
X-Rspamd-Action: no action

On 16/02/2026 10:49, Ilias Apalodimas wrote:
> Hi Krzysztof,
> 
> On Sun, 15 Feb 2026 at 13:06, Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>
>> The 'struct efivar_operations' is not modified by the driver after
>> initialization, so it should follow typical practice of being static
>> const for increased code safety and readability.
> 
> get_maintainers doesn't include me in the cc list?

I use only get_maintainers and as you can see no. You might want to add
yourself as maintainer of this driver if that's your part. Or have
korgalore/lei filters.

Best regards,
Krzysztof

