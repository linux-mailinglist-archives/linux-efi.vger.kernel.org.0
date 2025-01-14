Return-Path: <linux-efi+bounces-2631-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6999A10D2D
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D508B169BEF
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD061CEACB;
	Tue, 14 Jan 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gFXu5q0D"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A314B97E;
	Tue, 14 Jan 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874694; cv=none; b=WZLrvsJC+0PaJNALmaHFVCH/wKe151AG5crjK09rtVeFuuFYAIutLGiaRlfdX638Iv07OTvweK+pkj18s3wH/lz3o/kxF2pN0+60I0VoYMD0CZ/fDOM/6QP8g3CGahvyYBpvgBTfz36ISZiyxbQ8IgN4cqdglAZ/tSO8ArAc7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874694; c=relaxed/simple;
	bh=Xyn6dIyPBB9LkzrQS1m98P3wiMJvXrlGf48iyyNyGYI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dynlY07cRQL2lTj1EYPcH/rVJsqwdvan47o7rO6ZKpSkjFAzaec7nHmoJyGtvOcvMhsq/tY5gHuuQnC6NLcJfxjEvdSxQ0cWN5CTgpBhzT7VMQwlQ97C8Iv/mAVa+RXmgnajV6fsS2/+g9IGBN7VVOznhYEpRPPJisqb+cd7vl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gFXu5q0D; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736874672; x=1737479472; i=markus.elfring@web.de;
	bh=00vnptrSnwNPrAsLTXSUjpNVE+iJ/+8PHoZ9WDxkrtI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gFXu5q0D9t9ujT3rLT48ecCsvvrvMO6RqLN9Z4U13WkN2PJb0dp3CIaybxgrNmZp
	 IXMum38uaUWPP+mA9EM5XlrjPK/0u2h4JkL2cLlnajUmxXDSH0+Jdm8+Pi2IsaolL
	 0eaPW0WqxDlEO4FABoW7epXQwVqli8z/YDZWpoDSSR2PXcK0fc3qujKSA8ES5o2g4
	 13j1+SJk6J6TtBcIUhVp0JMKnG+/nUxTdAta/munnPr4OYO3HhUlrFNwiWyBwMnjt
	 BF+DMNec+M3wtNpaqZdFv7mlrmorJg194MTvshi8qekza+tp00JXhByVGD5NozahY
	 erem743D4EJX2Yp2ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.67]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMY1D-1to2oJ04c3-00OAFr; Tue, 14
 Jan 2025 18:11:12 +0100
Message-ID: <de667368-baee-46fc-9683-62cc92936e7d@web.de>
Date: Tue, 14 Jan 2025 18:11:01 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-efi@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jeremy Kerr <jk@ozlabs.org>
References: <7f7565d8-ef9f-4e5f-834b-9735db01835a@stanley.mountain>
Subject: Re: [PATCH next] efivarfs: Fix a NULL vs IS_ERR() bug
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7f7565d8-ef9f-4e5f-834b-9735db01835a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pUZYKmp03byp1/2GkXWAW1qDUSw9ndWjqdcDMpmDgU8ZqjRWoSG
 LuquM1YQl/9N8AVVmZ7XI/7yDziiJp0iqKt+bJRBFpN8MKZa+QPUknXdFHRcWBEwvXgPyvK
 CXPDJ7xOLLCvWvxF7eB4OsS+t+COsJI0BvBKau+0T9xolx6DQkbQ5g+RhuZ3HUlUBaZsyVu
 5a0XqfDm8psho/2JIpqUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WX+M4ixk4s4=;P9l/IXO/AyruVkBPecb1HagYWfR
 o16Jif7gYAEyi9C2qyelUf1oAMQFRksQ6aYPSuVF7fLehxgudk0j4Tj/AoCLrl1s9ii+Hjmt5
 T4KHuCdZ8SWidEH+603y14pYhQuZyXYVg6+x7aKQsZESku9VeCG0qrRHC84KOpbGcKAv/wxzo
 h3GvI75X3lABysmsLZbdmJOHcpJCnJUtx/3GGm81lzvy3LR2qwUZcJpm9555xgM67un0vFUja
 ZpUAXTxpkQ78P1dIWAi7jEFuilhXeaCxKhx9Wc3186ndh+FawVcOYVxGYWPFISXEy/E0RsqcA
 E7ey2wcdqVKys2XB3XcdTYFuaFPUMj6YnI56T+FMHp3BHxxvvzbAiOWpwas54zBEx9zkx5b6Y
 fljZGiUyve9x7hDXGmzggyY3u7NUcbjvoLwr4svmXkQz12UUUecwETMhJKijajy1UW95TDMgE
 u3BaWnhXXAfrVzTM0XT0NoWeXNJB/dgL9aAfwWQSWmOrzZdRxBqNCsY5GJaLZBMjk8I7VTuEE
 vAFwzeau8IS/8ceIvmipf696eKW+Kx2N7wvZoU0WQOCGmvvTYgNojO7DLpuA2HPzL3Sz7pFQU
 9xrXRrlQRnHGw0wvYBhdO+AsCiHu3H2hpAAFOBcvzA1mSKCGxcXQMmpoyyuGvZTZSvoIKokUu
 jpmWnnaRSA/XyzGX8vw1gwSMtxqpHW3UxR143cdF1ZwNnyqM/uXE1zKtgnddujkB7od59qFzJ
 2ZtNPdl7jTtUlaaQFe6JwPWn5S9R9tOxBgVqQEhZZLYGht5zCkATSYnkUX6K2I+wYjhEaKQI/
 v3H8u89jNAjwJmiifLtmddln8TNDvaf6xwnZ+yCWMb3xCjVcyheZ1Mw28VwHXVVKAn2zCjEVp
 giGWWYUGZrj+cvQsVdkEm92izeL3pY1qeMTNf8X3AlE9NpSWcQzyfoAQ8M/FnnazGcbJa+6No
 nB5IFyz9t/fUgau3cQmY/tkpoRKO1rg4Fr+fuIRgAVx5pac0/el/qfPHyL/mJoPtzYuPF8QGi
 2TocIp3sKU/k32gLt8Ij8VmTCtQTcMAwe78UGh1856jSxA4e/Oikdqih/AaOK1cwhJGToBBDK
 oJT4F4/So=

> The kernel_file_open() function doesn't return NULL, it retursn error

                                                          returns?


> pointers.  Fix the error checking to match.


Regards,
Markus

