Return-Path: <linux-efi+bounces-2955-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626BA5A6B0
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 23:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035E21738EC
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707E221542;
	Mon, 10 Mar 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="L4R1yTV2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57821ABB4
	for <linux-efi@vger.kernel.org>; Mon, 10 Mar 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644195; cv=none; b=drUIaUsTJWgD1ijuouE3MKWb3dGNQf49E7mvZzMJINj5LJlHIHkQ5IIF5aIg4Zm8WzYaaBPThNWb2XvugxMxE3GWhdG8W0Y7W0P8luJH7iNXmW/EqJAG2EcCGvNPQIwFdZQM8/fHCbuVUlH56tKvPC7KFNK4VEmYqkNocvIf9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644195; c=relaxed/simple;
	bh=NAa9k/aodlst9t+rht70IPa/ACctTjGwtyUuW6wAj7Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPahrBKdUF198SVF4BKzDPT0/hq1vN4BCN0SbuOCXJWXUrGwCUvmQWzOeJm5gFM9IcI0ZNde+ZKiXbZf/6iZXxzub5Ffaq7XXfUdpjJvcX0yGQvbDSaRBEEJKJmagllfP6EPXabb4sF0rcyKhOjbh1fNXmNx90Pl1qFVwTN6wv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=L4R1yTV2; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
	s=protonmail; t=1741644183; x=1741903383;
	bh=NAa9k/aodlst9t+rht70IPa/ACctTjGwtyUuW6wAj7Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=L4R1yTV2FfIy4zzlvqebmz9bqimT0aTG5WaT+XxXAQ4vn8n3TM20oaf2cQ/88rmYN
	 r4kV1lsK3kls+QUd9jph2fmg+BQbR7Zbum5895xs6NvG1XJqLFQzCyQ7CUl2xIVcwW
	 y8/UsE18WL+gU8xPSg0LTK3jh1AjrLAfmE3ZGBF94rxhYeRPLXgN/hN/2HxT4y+6mY
	 uaR187OUNBcVI2hZti5n9U9nvn4VBd2GvvV9/Ns48ONyfgBTl30Glf/Tyklw9Dakh0
	 xbrriDzRHpdWJNc1txLa4/t6QEjsB8XQVHb9cZ6vFViT4j1QpGMDfIPFnIOhtv8yzf
	 7uRJ8+69Jt8xA==
Date: Mon, 10 Mar 2025 22:02:58 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
Message-ID: <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus>
In-Reply-To: <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com>
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus> <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com> <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus> <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com> <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus> <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: c1453f33e9705d80eec809b08da32535ee6bd108
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, March 10th, 2025 at 12:44 PM, Ilias Apalodimas <ilias.apalodimas=
@linaro.org> wrote:

> Can you print 'target' in both of your success/fail cases...

For the first (failing) call to efi_allocate_pages() the value of target is=
 0. For the second (successful) call, the value is 88080384.

> ...and also apply the patch below to u-boot...that will print the memory =
map.

For the first (failing) call this outputs:

7 0000000000000000-0000000004000000
0 0000000004000000-0000000004200000
7 0000000004200000-0000000004400000
0 0000000004400000-0000000005400000
7 0000000005400000-000000003dae3000
1 000000003dae3000-000000003e2c9000
7 000000003e2c9000-000000003ea6b000
4 000000003ea6b000-000000003ea6c000
2 000000003ea6c000-000000003ea6f000
1 000000003ea6f000-000000003ea95000
4 000000003ea95000-000000003ea9b000
2 000000003ea9b000-000000003eaae000
4 000000003eaae000-000000003eaaf000
2 000000003eaaf000-000000003eab1000
4 000000003eab1000-000000003eab2000
9 000000003eab2000-000000003eab9000
4 000000003eab9000-000000003eac1000
6 000000003eac1000-000000003eac2000
4 000000003eac2000-000000003eac3000
6 000000003eac3000-000000003eae5000
4 000000003eae5000-000000003eaee000
3 000000003eaee000-000000003fb8a000
6 000000003fb8a000-000000003fb8b000
3 000000003fb8b000-000000003ff00000
5 000000003ff00000-000000003ff10000
3 000000003ff10000-0000000040000000

For the second (successful) call this outputs:

7 0000000000000000-0000000004000000
0 0000000004000000-0000000004200000
7 0000000004200000-0000000004400000
0 0000000004400000-0000000005400000
7 0000000005400000-000000003dae3000
1 000000003dae3000-000000003e2c9000
7 000000003e2c9000-000000003ea6b000
4 000000003ea6b000-000000003ea6c000
2 000000003ea6c000-000000003ea6f000
1 000000003ea6f000-000000003ea95000
4 000000003ea95000-000000003ea9b000
2 000000003ea9b000-000000003eaae000
4 000000003eaae000-000000003eaaf000
2 000000003eaaf000-000000003eab1000
4 000000003eab1000-000000003eab2000
9 000000003eab2000-000000003eab9000
4 000000003eab9000-000000003eac1000
6 000000003eac1000-000000003eac2000
4 000000003eac2000-000000003eac3000
6 000000003eac3000-000000003eae5000
4 000000003eae5000-000000003eaee000
3 000000003eaee000-000000003fb8a000
6 000000003fb8a000-000000003fb8b000
3 000000003fb8b000-000000003ff00000
5 000000003ff00000-000000003ff10000
3 000000003ff10000-0000000040000000

Thanks!

Ben

