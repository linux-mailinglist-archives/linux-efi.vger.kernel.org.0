Return-Path: <linux-efi+bounces-6167-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNgkNHtRlGktCQIAu9opvQ
	(envelope-from <linux-efi+bounces-6167-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 12:31:07 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593B14B612
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 12:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D9D3009FA0
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE53333725;
	Tue, 17 Feb 2026 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt/124FK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EE3271FD;
	Tue, 17 Feb 2026 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327860; cv=none; b=h8qgyst0bfh/sOjpmBQYQeJWEp4qh/wnMb9jBGp/n2MkatxFcmercUzNyh0ENx3HmHSr8pEqKOsH3uq3qtv0T0lKVFCo4MBVN2C+LHIT1f3oqbFI5QwZKkQ8x/2pRBRP+1ipKwfavHlkjDakEVsL45eqJah7xBgJZDgqe+Yu5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327860; c=relaxed/simple;
	bh=MoBw/M7yTwvIYgJNMf0Ti215ru/rCJSxdxH12EyqkRE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UVH1AC1GjKxM1uEi3Ld3DfJ1pqXVGHcG9asuvW6U8lg9Iv6uc+DHjs9FFf2kCVrYnOh6nZJadPyAXZIeovTnIWX0nm8T1tQXSnT9O8ifPbkD79krVksjS4K3PKNEpWL1SRHZ6bSsMr2IBQFAmXTY7zg6gNJdQ1ZSloKU0eF1fP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt/124FK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3680C4CEF7;
	Tue, 17 Feb 2026 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771327860;
	bh=MoBw/M7yTwvIYgJNMf0Ti215ru/rCJSxdxH12EyqkRE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rt/124FKXEMGsB7bD25BXeYp95XUgGbseWipfUuWLdZOOZv405e78t0W+h0fgRmj4
	 YGaOj0k5U3kXOJ8POmrF8zq9+tRd1rzKeealx4/oyEtCYMKFjaOQy0bLiYv9dgthNj
	 k4cOojt5hzgOT8W6nnPRuAmlMwK/pcQ3ff+Wc5zE4d3opZd2L9oYUTQGiIc1s7i3LY
	 uQXVc+SKy7IPRlQHBO661E9vZSwLzckiQcdZt9511KNara9sGhuEAIW4GLhHUOd0zf
	 iGPgutV6HBhq7zgB9aw7KJ8XQmcYwR6sR1FGq1HNxIOseh1EKtILCdUD882SXogm0o
	 BiVHl2E3Aw1ng==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF2A7F40068;
	Tue, 17 Feb 2026 06:30:58 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 06:30:58 -0500
X-ME-Sender: <xms:clGUablUvze5eKNUulZ--y_zP_LHYCe-ldwjYWGPjbIekxf0v2wJ3w>
    <xme:clGUaZocsAbWZ01UisRnjsktu6sKxYdGikBJUzbRpAePVTIYCsO2hyR0qkKgO8mm3
    oCnzM-VNV_OAmZkK8qwA-XoMv9SE-vO4N-NUP3TLTmdRlqv6ytTQjrp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtph
    htthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepihhlihgrshdrrghprghlohguihhmrghssehlihhnrghrohdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehoshhsrd
    hquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdq
    mhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopehlih
    hnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:clGUaUkeeLE4PbdNc1DmTaiXFcMcPqjjjHHfjg72dotE7YGG0GtJQA>
    <xmx:clGUaQZiciyB-9njMfRazOBx0CP3QiWhEuh3zjNEaz11jAtGA5AUVw>
    <xmx:clGUaXFZ87XFM_x0qiGwPQKDnvt7hXejvS9Bp8LOxOk3r4hKWv3DtA>
    <xmx:clGUaXacmb1x6AF7Vj0RhOabaaxvRjzzKKh98j5tg9rxgZ5Po0cY5w>
    <xmx:clGUaTx636mfQpbU1SNYFwMI9HGSvcHYQuJGZOf35EwsIX-xHYxjkFyN>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9718700065; Tue, 17 Feb 2026 06:30:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEQLpXAyzQ_-
Date: Tue, 17 Feb 2026 12:30:38 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, linux-efi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <93de9e85-faf1-4394-a374-f9207bd823c7@app.fastmail.com>
In-Reply-To: <5823f778-d422-4190-99bf-d66ffa437f6c@oss.qualcomm.com>
References: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com>
 <25d66619-23a2-4566-bbc3-83be8eae9d46@oss.qualcomm.com>
 <CAC_iWjKXcp8mmUaFphHRjJc+n3RNasVi91+_eP-mm3a9pnmYSg@mail.gmail.com>
 <5823f778-d422-4190-99bf-d66ffa437f6c@oss.qualcomm.com>
Subject: Re: [PATCH] efi: stmm: Constify struct efivar_operations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-6167-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3593B14B612
X-Rspamd-Action: no action



On Mon, 16 Feb 2026, at 12:07, Krzysztof Kozlowski wrote:
> On 16/02/2026 11:43, Ilias Apalodimas wrote:
>> On Mon, 16 Feb 2026 at 12:33, Krzysztof Kozlowski
>> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>>
>>> On 16/02/2026 10:49, Ilias Apalodimas wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On Sun, 15 Feb 2026 at 13:06, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>>>>
>>>>> The 'struct efivar_operations' is not modified by the driver after
>>>>> initialization, so it should follow typical practice of being static
>>>>> const for increased code safety and readability.
>>>>
>>>> get_maintainers doesn't include me in the cc list?
>>>
>>> I use only get_maintainers and as you can see no. You might want to add
>>> yourself as maintainer of this driver if that's your part. Or have
>>> korgalore/lei filters.
>> 
>> Hrrm, that's weird. Running it locally returns a more extended list
>> which includes me and Sumit Garg.
>
> You might be using git fallback, but this is not a maintainer. It shows
> random people either involved or not involved (like cc-ing me on half of
> kernel drivers), thus it is not recommended for daily use and all tools
> (e.g b4 or personal scripts) do not use fallbacks.
>

The code you are touching came in via a different tree in the current merge window, and so this patch doesn't even apply to the EFI tree. Those 'random people' are the ones you should have sent this to, if you had taken the time to look at the history of the code you are modifying. So please don't lecture other people on how to use the tools.

I've queued this up now - I'll send it to Linus by the end of the week. Thanks.




