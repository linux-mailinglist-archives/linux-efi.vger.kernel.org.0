Return-Path: <linux-efi+bounces-1008-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D298B846D
	for <lists+linux-efi@lfdr.de>; Wed,  1 May 2024 04:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C781C209A2
	for <lists+linux-efi@lfdr.de>; Wed,  1 May 2024 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9211C287;
	Wed,  1 May 2024 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u9k5afcU"
X-Original-To: linux-efi@vger.kernel.org
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A491BDE6;
	Wed,  1 May 2024 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714532394; cv=none; b=iIGb7nvpTqfUCmCblF7qaKY/5zM7ILCP1o2dcY1TbOs/QwP9D3sjkJjaLm5HTmmITA/z0PcNlHQ896mxQOlbynEqebxAFYPxwhKaZSGDiJeDRwqu8DDg8UONovgJU5enux5heRVVztf5/lzOgru55y3+syeE5fVqUC8YAqjr8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714532394; c=relaxed/simple;
	bh=d1tAv7N4r9JF1f3d8ExotiV9kCZfuFGqR1t9KPkg68o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=S8IEdnE0kN1Ei8cVfo0JtEv/+ilxBGJlr6zASkg7eV/0i+4WFv7SeFkIzCkYUQ5vPLTwfb1J1dfLuEAwc/zBQp4UIuBU2GxwouLg69qPkI29r6ZvcMW20odYiaqxA5cZaTtRZJWiwx1HbjvRb0xQVDQvKw3pTphTm0+9lVe2lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=u9k5afcU; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714532373; bh=d1tAv7N4r9JF1f3d8ExotiV9kCZfuFGqR1t9KPkg68o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u9k5afcUfWsKcQgPH1Wgu5Dl/BzvS6u2ExYXE2bpYS8yMQKxZs7Ud3EweV3jyRbNj
	 ndSl+ds0IPZEauehjRnRQJTtgKSkQBW/e6ABJ2/XPfrdam/gcMH/ZKAXQ1GStYi4ck
	 AFYdsDfYdlNBKPDBlMNUEdRbYPk753oPM4YFxiqQ=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id EDE08A34; Wed, 01 May 2024 10:59:30 +0800
X-QQ-mid: xmsmtpt1714532370tjm9c2u5n
Message-ID: <tencent_B777D0238556D2AEB121ED8D2151D8BD8E06@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjxGKrQADUKsPokn/M5v6KjP59P/aUwioO25gjK3CbXLdUHBmY5a
	 ekm4emHbJQkzcEKm2hvLtBvKcLOaV/+Ut3Uhwd5g/ozh4VXaWblwj5BJjzrZPMEkj4UtaqcsTymG
	 e8vDIaw5qLrbzw9uDMQhLii30+bieExBE3zyFEbAY+Kz9SC36m639PhjOB2y2DDYjpaFyQ5RINCb
	 zDQoLjGTZKdzcPV/48CZyElQqZhalSWV5pHqXqpyDt0wOn8hrvJmezN9z9VWpqW7rdAroVeHmcB8
	 zUb+pQoS+mkNQ5G+3P2uGm1XExWovdddxYycB7LMqdSM+GjmZVLbA2pnkrIUR/zvted+2xaSbVwj
	 cyBXqWjcSj0Y+AFWN+UF+eJXoJRJ0wWfaSAGY1GPOX5jXGZ0zZ5XfMU49AgChcxqFnqdUatM/vJi
	 FSfX4fN0JDKJtFdsttvCOTolpahvcrsYP5/RzQD5zRaaa7UaFLoXJqFcjJADdxxV/LzI3PQypXkF
	 RaNBBfnDLcHSm8Aggj/I/LvNN2VsUd/C9L11YQKlyKfoi4sv1JyF9pf51wFgkDiNEFtv+8snRdrf
	 WGiIJcJ6YyXOfON5nVtKiJva4HOwpXPbqmEFU7zURn/Lv/dbUcfQxYDxgaUHVcJrxheVRWALeBAJ
	 qdeyd6pCul/ePl2ek1fD8vQOGfRXNKC9qrBvM5tyNrGOmi3s5holmlbklF4jYVEorTT8cX18ew0O
	 7XVfF6D+tGuA+/+7mk+07x2z7SlO98VVl94Hdr6u2OyENxieWlvMRQ7DzY47ifxiTd5w9i2s26i7
	 YQgXtVaoxIgOsV3qGZuITFm/vVk/ixFAA9jfhuy6VkmWrrDNoVVjk0fwiX97C7AJaUP7+z2t+LrJ
	 7rUvZIRlAfcYLqN5/81cLsOYzVPpd2BTXW+3IXY22ZluDEoiIYS4iFJx89ujIcnuSCLN/q4vHKqk
	 r09YWqtXkCA7ppX6iat67k1EAGtpP2yWVeO6TkN88s2zTqAl7siiUJVUh1Yol9
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: linke li <lilinke99@qq.com>
To: ardb@kernel.org
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lilinke99@qq.com,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	xujianhao01@gmail.com
Subject: Re: [PATCH] x86/efi: mark racy access on efi_rts_work.efi_rts_id
Date: Wed,  1 May 2024 10:59:28 +0800
X-OQ-MSGID: <20240501025928.63749-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAMj1kXEfdJ9SzPO7NpYwXW3uPGYNOzVFndRswLZb=6TPAgN5TA@mail.gmail.com>
References: <CAMj1kXEfdJ9SzPO7NpYwXW3uPGYNOzVFndRswLZb=6TPAgN5TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why is this the only reference that needs an annotation?

In the function efi_runtime_services_init(), the if check on
efi_rts_work.efi_rts_id in line 728 uses READ_ONCE(), and the comment
explains that this is to reduce reports from KTSAN.

I propose that the check in line 754 undergoes a similar treatment for
consistency and to potentially reduce sanitizer reports.

Thank you.


