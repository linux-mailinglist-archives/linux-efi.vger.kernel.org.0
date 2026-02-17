Return-Path: <linux-efi+bounces-6170-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHlrHnJglGnODAIAu9opvQ
	(envelope-from <linux-efi+bounces-6170-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 13:34:58 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A198014C02B
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 13:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 404D730046A7
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFEB352FA5;
	Tue, 17 Feb 2026 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LiAIaRXs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjzHII7E"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9233555D
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331692; cv=none; b=oGgEAR1GAUnCtWSSbGSWRqSISQEwkVIkgCq49YabBolii8VuLSAevDc8pAGH4lx1bGd+AMWy9GAXNspJK4eup5uZZGhqrmRL40wrfnGDgiAdnQYIiKFTW9VvajEKwrZ1gXU/X07ibr1XEIeMbeZyS3XFdkrrITTxBwKvPltf/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331692; c=relaxed/simple;
	bh=k0PDVg58bXEO9ATpH3R8UPaGClW81v0PAOINPuiAK2c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m0CyjqkAbOw/6eEttrtPb62f+1nXoofqmuWIiEsZPkxalUKzZeBofsG/wgccFzO1EO4JtXkm56OBNxQz1I3334zQcjbyixaGXURPoyvAwHkRZHGqLkDR/18YaBQQr1HE/lnkOeE5j/9vyJ2w4F1slY0S8kj+vq92x0qPX02zyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LiAIaRXs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjzHII7E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8Lj4i297047
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 12:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RvEfrZDrpuXSo+8UNBbEgYFKbls9A5JiTcAP/1CGaK4=; b=LiAIaRXs6HrgIe0+
	27FH4f1ZJkA90Rn3x5DuZnLxWfb7ctBdh1/h9y3Y6nFB1n7y4u2xewOr1l4VMCLI
	U+QdDR0jpa1truWImPQNSjcRzZT7En5fDGHU0T6Km88oJSt0MBsOWytfUC4a6XN0
	GODy77SLMl/95YPqBphumuirnDZjftkrFL454+ih7VITZXTbMXOlk0Y45NN/lt/2
	7Ek5yD8H/OfQs3mAfkLamPiTQM725CLBc5DeV1Xyu/l6eLO0CUCNoAf3+pmAK1AV
	GjTggxvXufhDb01ph8JhDoM/RtfCP44zkHThjOh8fULjF5M1zKIakjtDetK+GJEJ
	nll9VA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9tc00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 12:34:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb706313beso9530485a.3
        for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 04:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331690; x=1771936490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RvEfrZDrpuXSo+8UNBbEgYFKbls9A5JiTcAP/1CGaK4=;
        b=IjzHII7EObO/TNAnVtNn4YMF0QsywkD5tQko/bGCBvOqNVuvjfQqAo5cL2T6ovVgIZ
         MSKkjlcWtdF8RBKvMw5lzxLZ0PTvWTb6ZqxufgDsv5kr0T7008cYjcDH/lGD3gy5XUVW
         6Yod4jnJzPp093h0LpyjQvHUaaedBv/8RMy0uqgDEwTxx+QeOkv+9+P+LGZbXjTAmAX5
         qR/uRbaAPM515xsiYvd0vbsoLoUfSJsJRb3UCc2gCMoFruKS5ipCz9STYXm0jvWaqq6k
         LYRmVsDIe0v3+14GPBtcjaHPUstnWfNH7ABpJ0p2NRkNgit5WVE8zqQYPxewTV4CUlLn
         kM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331690; x=1771936490;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvEfrZDrpuXSo+8UNBbEgYFKbls9A5JiTcAP/1CGaK4=;
        b=d6f7uYXxceCjpkcJ+GlKm6C651uHckbLuF/y+AXqshSHVsiUnbmsD2ZsKbEKQS66iK
         TL6E5RQrJgGCd1C1DdK5xASvWJTNvHQqjhLGKIpvWSTn8+FOpeBkuacdJRaai41DKV3i
         syYrTMek7mVQP4ns6IOh8RN3ByYTHTIOb1relVXM/D2LCHIOV+A/TW2XIPLy+C+zJ0v4
         HyhTbUeHzT4eZsKtm5FcRtSFV/yZOF9Ix5eFkYz/N5CxiI7q4Qa/ht9++DE4zlHGBvmI
         DDmXjwg0ApWslEkJspJTEYHbANlkImYXMXy0ND9u4uq1hloUqSVCrEi9Usy5ZJ56oG2D
         7a8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAGCjIlLu8YuDBmcDEga+Wo0OR0RmNCZPqWWxMO45hpsfOIC0AEZwp6ZnDzdxejAx/RrskvXPwkug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKb6iqkO+3GEqx4KsXebY5RgP1b/DzTAnQsB9WP6tflTDP9T6F
	0oDHqGglE77suVd8daVfduHV4vqaGDmwr/01HWtzFxD8/7TyPKYB/LUnEGzcjtgkZi/PMJHo3kP
	nE1iYaKzezuhvz1oNDxX6mGRxR0asBsLrR+b5/pzl+emrMEcktBZSnNjGvcty5Ms=
X-Gm-Gg: AZuq6aKFEQlmkxUKJChKVHT0wwIDBMKF/l7pqBfpC6Y1bgoX/QpOYg6PMscloCAZGFd
	v778k7NAKQQKJBZyo5v3swsPTAhQ33FhHwgvrrg2+abt1gqLGduLWw6oyldO8SQYm2/xeJGq2dT
	Wd1+bk+CJx0Q1Pw08nO8kFBZbfRnwOZI6an9Ow67tBE8evUkfN3N6CGysVFGjkle1QChAuxpmfT
	1lbuXVo9fCJsQL/0bt3SBD73lJfdvpyvE43Jxe4aZ0EwXiWuChz0TfFSCRzV8xTGmWLiP3psdLj
	jj9l1MCxOrOf5i66kEFu74Qd2V9FXo6vuZ5ti0EbpnsVaWkFAr59d59vzMwrbF2eUVi0mq/szXX
	fJr5sw4qjGCUjKgvz1R+m4inTehJppAOWVJZFulkbanG8tzTbDw==
X-Received: by 2002:a05:620a:1927:b0:892:7dd2:9f0f with SMTP id af79cd13be357-8cb4228d6d6mr1362114885a.19.1771331689737;
        Tue, 17 Feb 2026 04:34:49 -0800 (PST)
X-Received: by 2002:a05:620a:1927:b0:892:7dd2:9f0f with SMTP id af79cd13be357-8cb4228d6d6mr1362112085a.19.1771331689224;
        Tue, 17 Feb 2026 04:34:49 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac9d77sm31558282f8f.33.2026.02.17.04.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:34:48 -0800 (PST)
Message-ID: <a2bd86d1-58ab-4a03-9539-74406b20861c@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: stmm: Constify struct efivar_operations
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com>
 <25d66619-23a2-4566-bbc3-83be8eae9d46@oss.qualcomm.com>
 <CAC_iWjKXcp8mmUaFphHRjJc+n3RNasVi91+_eP-mm3a9pnmYSg@mail.gmail.com>
 <5823f778-d422-4190-99bf-d66ffa437f6c@oss.qualcomm.com>
 <93de9e85-faf1-4394-a374-f9207bd823c7@app.fastmail.com>
 <3ae05b60-0428-40ec-a6a8-e60395a8dccd@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTpLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+wsGXBBMB
 CgBBFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmkknB4CGwMFCRaWdJoFCwkIBwICIgIGFQoJ
 CAsCBBYCAwECHgcCF4AACgkQG5NDfTtBYpuCRw/+J19mfHuaPt205FXRSpogs/WWdheqNZ2s
 i50LIK7OJmBQ8+17LTCOV8MYgFTDRdWdM5PF2OafmVd7CT/K4B3pPfacHATtOqQFHYeHrGPf
 2+4QxUyHIfx+Wp4GixnqpbXc76nTDv+rX8EbAB7e+9X35oKSJf/YhLFjGOD1Nl/s1WwHTJtQ
 a2XSXZ2T9HXa+nKMQfaiQI4WoFXjSt+tsAFXAuq1SLarpct4h52z4Zk//ET6Xs0zCWXm9HEz
 v4WR/Q7sycHeCGwm2p4thRak/B7yDPFOlZAQNdwBsnCkoFE1qLXI8ZgoWNd4TlcjG9UJSwru
 s1WTQVprOBYdxPkvUOlaXYjDo2QsSaMilJioyJkrniJnc7sdzcfkwfdWSnC+2DbHd4wxrRtW
 kajTc7OnJEiM78U3/GfvXgxCwYV297yClzkUIWqVpY2HYLBgkI89ntnN95ePyTnLSQ8WIZJk
 ug0/WZfTmCxX0SMxfCYt36QwlWsImHpArS6xjTvUwUNTUYN6XxYZuYBmJQF9eLERK2z3KUeY
 2Ku5ZTm5axvlraM0VhUn8yv7G5Pciv7oGXJxrA6k4P9CAvHYeJSTXYnrLr/Kabn+6rc0my/l
 RMq9GeEUL3LbIUadL78yAtpf7HpNavYkVureuFD8xK8HntEHySnf7s2L28+kDbnDi27WR5kn
 u/POwU0EVUNcNAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDy
 fv4dEKuCqeh0hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOG
 mLPRIBkXHqJYoHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6
 H79LIsiYqf92H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4ar
 gt4e+jum3NwtyupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8
 nO2N5OsFJOcd5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFF
 knCmLpowhct95ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz
 7fMkcaZU+ok/+HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgN
 yxBZepj41oVqFPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMi
 p+12jgw4mGjy5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYC
 GwwWIQSb0H4ODFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92
 Vcmzn/jaEBcqyT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbTh
 LsSN1AuyP8wFKChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH
 5lSCjhP4VXiGq5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpF
 c1D/9NV/zIWBG1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzeP
 t/SvC0RhQXNjXKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60
 RtThnhKc2kLIzd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7q
 VT41xdJ6KqQMNGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZ
 v+PKIVf+zFKuh0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1q
 wom6QbU06ltbvJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHp
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <3ae05b60-0428-40ec-a6a8-e60395a8dccd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNCBTYWx0ZWRfXyuF/0mlzKuyY
 kzaBgSq6FCUgTZA3h+wgrFAONBpjjnQqYxmtP0kCONrKqvrW0nDFuYvi7L3an4rjMhK3vj+MHUe
 pzJaFGNrZH94D+hT4bowaHJmpLkJU/cvRJrdmD3zt1lffXLEgovqx6y7ZovUh4a/t39n91cGJ7R
 /SpdQn/vouu26HdMvLqgXMawyLmyoaL+inFJOWudGR4YCSe1r893dcIYZIMSWGI/Ty5LHKO7zGB
 d1kx7Bfnc4wQ9RzK8qyjvJuJsVtkEEUCOh7m1/Ap7rZnNUadwBXMKVqKKmkkamBQ1LSTf1+g3mO
 7FM/2GV8OI8SaXbHABi5Gc7dySD2VUbnH/XCOBSZ1uXcKOGSU44OKAVSTH2p7ygqoXfJcUqF8YS
 SOtGvgXLwRWIEu6w89m4Ge5UOecdAqK7d9pKB7sIGQ9qH1fNEHEL1VidY4SK1ywka/KFhuLdYQQ
 N/cTviik24jb7WqvGJA==
X-Proofpoint-GUID: ISs06XuoKKOA1lZRt_bQXodjJoxEjdD3
X-Proofpoint-ORIG-GUID: ISs06XuoKKOA1lZRt_bQXodjJoxEjdD3
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=6994606a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NT1zQuG-P9saifzZ494A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-6170-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A198014C02B
X-Rspamd-Action: no action

On 17/02/2026 13:25, Krzysztof Kozlowski wrote:
> On 17/02/2026 12:30, Ard Biesheuvel wrote:
>>
>>
>> On Mon, 16 Feb 2026, at 12:07, Krzysztof Kozlowski wrote:
>>> On 16/02/2026 11:43, Ilias Apalodimas wrote:
>>>> On Mon, 16 Feb 2026 at 12:33, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 16/02/2026 10:49, Ilias Apalodimas wrote:
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> On Sun, 15 Feb 2026 at 13:06, Krzysztof Kozlowski
>>>>>> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> The 'struct efivar_operations' is not modified by the driver after
>>>>>>> initialization, so it should follow typical practice of being static
>>>>>>> const for increased code safety and readability.
>>>>>>
>>>>>> get_maintainers doesn't include me in the cc list?
>>>>>
>>>>> I use only get_maintainers and as you can see no. You might want to add
>>>>> yourself as maintainer of this driver if that's your part. Or have
>>>>> korgalore/lei filters.
>>>>
>>>> Hrrm, that's weird. Running it locally returns a more extended list
>>>> which includes me and Sumit Garg.
>>>
>>> You might be using git fallback, but this is not a maintainer. It shows
>>> random people either involved or not involved (like cc-ing me on half of
>>> kernel drivers), thus it is not recommended for daily use and all tools
>>> (e.g b4 or personal scripts) do not use fallbacks.
>>>
>>
>> The code you are touching came in via a different tree in the current merge window, and so this patch doesn't even apply to the EFI tree. Those 'random 

Heh, and that's not even true. The code I touched came via YOUR tree
with your SoB:
c44b6be62e8dd4ee0a308c36a70620613e6fc55f

and not in the current merge window. I don't what commit you are
lecturing me, but I see:

"Commit:     Ard Biesheuvel <ardb@kernel.org
CommitDate: Mon Dec 11 11:19:18 2023 +0100"

There were however context changes coming from other tree which affects
applying the patch (thus won't work for your tree indeed), but if you
just bothered to check, you would see I don't touch ANYTHING from that
part and actual code I am touching is from 2023.

> 
> It can wait till the merge window finishes and then it should apply
> cleanly to your rc1 rebased tree, no?
> 
>> people' are the ones you should have sent this to, if you had taken the time to look at the history of the code you are modifying. So please don't lecture other people on how to use the tools.
> 
> We are all using the tools. If Ilias is/wants to be the maintainer
> (which I support), please add to the MAINTAINERS file, so the tools will
> get it right, instead of relying on manual process of finding who
> touched something. Contributors should not figure out how the code ended
> up in the kernel because it does not really matter. What matters is who
> should take it, who is the maintainer.
> 
> This is not a fix, so original author won't be pointed out by
> get_maintainer poking at Fixes tag.
> 
>>
>> I've queued this up now - I'll send it to Linus by the end of the week. Thanks.

Best regards,
Krzysztof

