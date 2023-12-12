Return-Path: <linux-efi+bounces-185-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4180E06A
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 01:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF541282305
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 00:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E0264A;
	Tue, 12 Dec 2023 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="j8DHAwuP"
X-Original-To: linux-efi@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFFA6;
	Mon, 11 Dec 2023 16:44:20 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EC0F97A3326;
	Tue, 12 Dec 2023 00:44:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 648F07A33C0;
	Tue, 12 Dec 2023 00:44:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702341859; a=rsa-sha256;
	cv=none;
	b=WfVG4SSwRyXeEqf06z6ACiV5ytZmhy8gZItJKq1SZZNPSqMWTNLZdEpGnj2IikrokX+bOp
	s0up7pk6JlFMqOnKYaniYfFQnOs+leFOHCCEDk54VR3YsTcWxoZFJfIzT3/Sg+p5tRMJve
	FAkH7Z/Drgnw00iC6KLa4BWv9dTNC92K1hPkCmIVKK6IblntrLG+aYl6HIa+0hxylA1i96
	AY2P9rpTlSFSMXuwqcJXCCo7cxAdGWOg++zjOi7Sj4QAc8kwCIxttfMsEAZ8HtGaFc9OO6
	Mt90yxfTUwD3uOeIumnJMvaoTwLhOP8a8Jc2A4MYiiR0yKGLTEXckL9nH2lNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mF/Vo4/Bjp0KnZuQHVj8rbwp5yFhrkFsYdhlOMyaCbg=;
	b=Wh5Khxytvukjt8QWDslzHoUND4LTPJ5D7neQ9e14wl4E2ZVZ3qCm7MSWLKYWWGNegy4pay
	JLp7H03isdxZ/p+VLUsMW4aIGgNM3eprQDR3i+F9kgZdgXb97wipEXH4dv2TeTreZQDE6k
	umNftFkcSeiG3/jOFDp4m3Mcc4BjtdE+X9ATFZZVHSNGecchJYLZzeso/NnQ3nbCY0En0M
	6t7OIgJcvFjV77ZB56zRGhfBjGZ4vv8O+9PN9Dw4/5o+3rRA9mBYBOfD7XUTfQNvzHWKaz
	j1vsMLhwqvyiVrHd3yqfVSoQYi1rNANrlmZh1L3fbnJ9N4QO/lYGfwCMuZOu2w==
ARC-Authentication-Results: i=1;
	rspamd-5749745b69-czvrl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Fumbling: 2d7025c1535d992e_1702341859740_305295213
X-MC-Loop-Signature: 1702341859740:2844852777
X-MC-Ingress-Time: 1702341859740
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.58.202 (trex/6.9.2);
	Tue, 12 Dec 2023 00:44:19 +0000
Received: from offworld (unknown [172.56.169.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4Sq0HK3kd3zqM;
	Mon, 11 Dec 2023 16:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1702341854;
	bh=mF/Vo4/Bjp0KnZuQHVj8rbwp5yFhrkFsYdhlOMyaCbg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=j8DHAwuPoFxHqrqS+yeA0YQa9yNrbyRSTaNAJFkQE+UqKgg1Q1MsLd7CWm9jceUYN
	 O8TQS51/TEiDQPKOLg71Hp9nYqh0ifF3wfMDAagn35iH5p5GbMj/pYh9H9jz0Xrdsz
	 JHTaD4I7dFMfUgq9MBq4LlpcqToB57JIanyIuk8epPFGbOFLw/pps//E8v5oHKBJ8p
	 MLgoxBSpI4k1oN28wH7TTbumPC5iczULbNMObYAfuN5s4/3AGJmTeMx4h/wU8hC2Tv
	 hDB6PQCnIwUoX5SSmZ8H3qKfsuQedvUE0rCtSjIeUr2eLQNy+xtauPd0rM2ylxPwxJ
	 WsCD0D5XkTN0A==
Date: Mon, 11 Dec 2023 16:43:58 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ard Biesheuvel <ardb@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Add GPT parser to MTD layer
Message-ID: <cykfpuff32nuq3t27vd5tv463cx32phri473fjnrruvom5dk5u@uao5e3ml73ai>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231211151244.289349-1-romain.gantois@bootlin.com>
User-Agent: NeoMutt/20231103

On Mon, 11 Dec 2023, Romain Gantois wrote:

>Hello everyone,
>
>MTD devices were historically partitioned using fixed partitions schemes
>defined in the kernel device tree or on the cmdline. More recently, a bunch
>of dynamic parsers have been introduced, allowing partitioning information
>to be stored in-band. However, unlike disks, parsers for MTD devices do not
>support runtime discovery of the partition format. This format is instead
>named in the device-tree using a compatible string.
>
>The GUID Partition Table is one of the most common ways of partitioning a
>block device. As of now, there is no support in the MTD layer for parsing
>GPT tables. Indeed, use cases for layouts like GPT on raw Flash devices are
>rare, and for good reason since these partitioning schemes are sensitive to
>bad blocks in strategic locations such as LBA 2.  Moreover, they do not
>allow proper wear-leveling to be performed on the full span of the device.
>
>However, allowing GPT to be used on MTD devices can be practical in some
>cases. In the context of an A/B OTA upgrade that can act on either NOR of
>eMMC devices, having the same partition table format for both kinds of
>devices can simplify the task of the update software.
>
>This series adds a fully working MTD GPT parser to the kernel. Use of the
>parser is restricted to NOR flash devices, since NAND flashes are too
>susceptible to bad blocks. To ensure coherence and code-reuse between
>subsystems, I've factored device-agnostic code from the block layer GPT
>parser and moved it to a new generic library in lib/gpt.c. No functional
>change is intended in the block layer parser.
>
>I understand that this can seem like a strange feature for MTD devices, but
>with the restriction to NOR devices, the partition table can be fairly
>reliable. Moreover, this addition fits nicely into the MTD parser model.
>Please tell me what you think.

I am not a fan of this. The usecase seems very hacky and ad-hoc to justify
decoupling from the block layer, not to mention move complexity out of
userspace and into the kernel (new parser) for something that is already
being done/worked around. Also, what other user would consume this new gpt
lib abstraction in the future? I don't think it is worth it.

Thanks,
Davidlohr

