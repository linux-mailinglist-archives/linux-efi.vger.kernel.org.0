Return-Path: <linux-efi+bounces-4093-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E284EAF66E2
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 02:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80414E3097
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 00:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D68433A8;
	Thu,  3 Jul 2025 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nQ0nqKqI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C91805B;
	Thu,  3 Jul 2025 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503556; cv=none; b=MhHnqpbu4KiA5vq3d1YO6nWS8FL5dhEKJGmqFP40XD78gTCTaqoefe9Kwb9R7fm1eS8TfIG8ZCYrGi44sosZkIvCd/b5ODEygyyyj+QZm9rVZ2Vgl0gtrjXgUN2xEjK6GAjXFlATYLtwYo5T78qDHSxf8corQogu9hGuQLakJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503556; c=relaxed/simple;
	bh=gqVwsTf1RbDMBGI6NC7IAei+tBABi5OpJrP6WS49am0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iPm6THUePTGzoJz11uMRiJXVzgVY+bkl7H1v3Z+Pzb9zmsQb89T40LtP0Y0mX3wDo5IvKtRFG2u/KvsOry8UqNRPWU3yKRwX53xFB3YhkB6KqcR3v5TkL7BOsvhLwqjKeQld+44fU7/UavO+s7klR/Y8JtJtdK+tSZi9SNPkV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nQ0nqKqI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5630iVix883449
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 2 Jul 2025 17:44:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5630iVix883449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1751503477;
	bh=gqVwsTf1RbDMBGI6NC7IAei+tBABi5OpJrP6WS49am0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nQ0nqKqI1dMMgHH/T076moHv3GhmKmfnDmvtQ/lPVjTSmklzuCdYtdTnX7aTHpwPr
	 t4eSbAsWbC9PPPZ8SNoNNp1sPcuzHq1m1zs8h39tJ2SFlppDC1+8c6j5dDYqn263nE
	 Xd5SoVpu3bUaVfw/AxR9phjJRDn2Jcnm7rz0b733rPbWve6CHmIONNWbbRtdE57fJj
	 IV3edOnFFb/msDoUjJspXOlNMKXd2025/2Q7FGhSAxqcf0iI06mRJwtLW+HB73bSWh
	 ghs3D70M7wDw6FRFuP6Kfy7rvi8vHNPlvdnadUuui60qSUYI1Y2aARUzZZdLizFZA8
	 3ZbPG75PWzW6w==
Date: Wed, 02 Jul 2025 17:44:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: acme@redhat.com, aik@amd.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, ardb@kernel.org, ast@kernel.org,
        bp@alien8.de, brijesh.singh@amd.com, changbin.du@huawei.com,
        christophe.leroy@csgroup.eu, corbet@lwn.net,
        daniel.sneddon@linux.intel.com, dave.hansen@linux.intel.com,
        ebiggers@google.com, geert+renesas@glider.be, houtao1@huawei.com,
        jgg@ziepe.ca, jgross@suse.com, jpoimboe@kernel.org,
        kai.huang@intel.com, kees@kernel.org, kirill.shutemov@linux.intel.com,
        leitao@debian.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@rasmusvillemoes.dk, luto@kernel.org,
        mcgrof@kernel.org, mhiramat@kernel.org, michael.roth@amd.com,
        mingo@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
        sandipan.das@amd.com, shijie@os.amperecomputing.com,
        sohil.mehta@intel.com, tglx@linutronix.de, tj@kernel.org,
        tony.luck@intel.com, vegard.nossum@oracle.com, x86@kernel.org,
        xin3.li@intel.com, xiongwei.song@windriver.com, ytcoode@gmail.com
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
User-Agent: K-9 Mail for Android
In-Reply-To: <4dcd23cb-eb55-42e7-aa76-dbaf2e2a7e07@citrix.com>
References: <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com> <4dcd23cb-eb55-42e7-aa76-dbaf2e2a7e07@citrix.com>
Message-ID: <5F0DC7C6-58D9-4316-AFCB-3F002601DA9F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 2, 2025 4:42:27 PM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2Eco=
m> wrote:
>> Note: for a FRED system, ERETU can generate #SS for a non-canonical use=
r space RSP
>
>How?=C2=A0 Or to phrase it differently, I hope not=2E
>
>%rsp is a 64bit value and does not have canonical restrictions elsewhere
>in the architecture, so far as I'm aware=2E=C2=A0 IRET really can restore=
 a
>non-canonical %rsp, and userspace can run for an indeterminate period of
>time with a non-canonical %rsp as long as there are no stack accesses=2E
>
>Accesses relative to the the stack using a non-canonical pointer will
>suffer #SS, but ERETU doesn't modify the userspace stack AFAICT=2E=C2=A0 =
I
>can't see anything in the ERETU pseudocode in the FRED spec that
>mentions a canonical check or memory access using %rsp=2E
>
>~Andrew

You are right of course=2E Brainfart on my part=2E

