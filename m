Return-Path: <linux-efi+bounces-6274-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hi+Aam9rmn6IQIAu9opvQ
	(envelope-from <linux-efi+bounces-6274-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:31:37 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B33238E06
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83B20320712E
	for <lists+linux-efi@lfdr.de>; Mon,  9 Mar 2026 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719D3A4F2C;
	Mon,  9 Mar 2026 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="X2mtL95/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457567FBAC;
	Mon,  9 Mar 2026 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059049; cv=none; b=r3sqgki51IxX7y2qWcllLXSHBAD8j81U9HcypJrl/5jKVJYkp4N2dkZHKCRUznk1UJelbH/N5sE42fAcRF3FAG5muCY5sE4+IqMJYNVwuiwl5J9RNBH1ZBguRqmXnEBnhRyFgnBGFpAwk4gqVvgP1U6WLBARTlALroiM4qaeNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059049; c=relaxed/simple;
	bh=7FUD8IrgsVso/2HALPt81pCK50kclAZr6xq2T5LvlmE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=aIhGkFLjNxTKLmFwRHnXS1UwNzQR1sbj8/AnLbDJaMWnbWOL0t2kZxm4bN+F6doix15NZTFXQY4d0/cuXk1ik+EfiN7MU6gcjSLHDU3k0KzAsKn1I37xqbJGD5n3oTEZAFFJPRofJxDagFC8/g2nvn0ihOYLghwOOBsPAMsxQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=X2mtL95/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1773059045; x=1773663845; i=aros@gmx.com;
	bh=7FUD8IrgsVso/2HALPt81pCK50kclAZr6xq2T5LvlmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X2mtL95/mM1EOcKuck919Gajf/nANbMD0ddi82iMXFBw3QGta0esMDAiWdQpLwR/
	 gErtJfjpOXvrFXTPsJ0XRBdj9SnJ9p2Alb/1ipJFe8BcyffUlnzjCrHVgKFzvHRpV
	 CGELHRDoB8qYxkJckppJjENd4mkKsJlJR6dtL8zZXNx1xqDcYR09Q38XGwugJoaG/
	 8B2c1oz829rX/Jia4PUY0odWq3GmDPgc/2GM5uJrfOS+TsBy/YWV1es0YK5WhN5GY
	 Oze/UiOiaBjaDQp9uTiM9iElDAPoiCZa3LqL1cUyOtHr/Kz3aNLccfwe1c7MAu+Pn
	 vpzsQtyi+uNl8rVXBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3il-1w5v9b49QR-00M4UL; Mon, 09
 Mar 2026 13:24:05 +0100
Message-ID: <2780abfc-39d1-4441-833c-65e66f747054@gmx.com>
Date: Mon, 9 Mar 2026 12:24:03 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: x86@kernel.org
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Subject: x86/msr + lockdown: allow access to **documented** RAPL/TCC
 controls under Secure Boot
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8wayMM/4UokIlJ33YHzPTDp+P+3mTDAPDuv/ydJgc4H1s4201Lx
 d0klS8w4nkt1O0w+DxnTfue95UMuhJzT1bPqf/e+NTRCsOu34n1g3HC99eQd7XtmvBcnIG3
 7Y5R6DuvId94iBArTWMuRpSOYr8g1wf4/AnwWHBhJ5NRbmL0L/qJBUAK0Qz1pB6OrRDvOMX
 oARkBxVeVSW8cJBwj0SJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:822MMOM9/Yk=;Pm99qzrgwGYKMHqDMEViadFXsya
 aRXWRPX0ejXcpt2WYwB+bPavbrN1Qcm/cz54lRmqlXWpgFXMlbD4290mCvCJdqOTs431TC914
 emP14Wa+TCmYpgOdETxBIfn9VsH5sB9sjv6UlEl1o7dbO5sDXlHSwgLkxoQQr/F9dG4yHcXkM
 YVmstxVtstNAwv/toNFkP5ESKd4zDKwrdBTeIPss21NAgsW1AvmfXCszHemBH30n9zH6VxKR3
 7mj61kyVa7prOFsKVmQXdx90Z5bLlqkdBXEl7mDvx9HjDs7awF/EQa8XBTQ0hhGWndvnwsdhx
 244r6Vodj2+86yO92fIJmFCGVQr7Olh05zWBiOskkK4YZMOYR9aDQw7UM0ZH4m5W8BAQrJRN1
 kQzIk4ceCjEEhmD35VVnvmsy6/GOVT9JF4TTLk3MK6XpBVc2nSGWA59GUG2SQu0C5iq3g9rw7
 nKbs5S/ueMUOdCuzggXvKyECzr5+rKqaQJwO+knkdtPUCVmQbRRVWzYVuXVMzZ0e0S/Zv+two
 vmQqJ942akWwQZSLzJE8kRAssejlPJsJL+wlNa/jj+qjVb7/hKlv/LyiPSnHMFFnOJUzeFDSH
 8LQHAiFJn6T6B4Ewlb/iFaPdzZ8xf1moEOu1ZSgFJl/8zJJbxOcpkobtBt29B7a+iqIuEaNXQ
 Hg5e5kAwUCt2QG4WOK/08H58D+EyZgNNaKbV8wLy5huoQsLmPYaUwOsVn6NztFDL+e+LRTWY4
 axioSJmRnUrra4WLMFI7sj36B91zHABhVDyRtjtFo/nMdByzNxQCeIX8n6WMe/KgXmr49E52B
 MDbg6IA8j0JoTmm+TeMq/2v2qFmScHtjqha/HRV1vxur2Dm6r9u+2PXbPATAq/dlq5u+y4u9D
 S9M5FKU6FiINVFe3e7JEbRRhuidXQkSKyWSCaXWbbiToKpk1C2oVVr1ZIUgaosZgTK01/RNEo
 +NtgIGloMTR3/P9IlXNj+MsmoO8aYfzR1/sW5rKlI43FW9QxXfHO550U8oXI8SlS44ZmHBkGP
 wyO5va1aX5G82B+qGb3u75gmKDrH1SSLyR+PC4Im6J8PVjJlyRywfJnclYXB9g76mjQVqU3Np
 3pmJxL4zM/wdtEt6fMYHylwFyAzjEb0DKMld4suvsPaJSGaUBuU9/vsmI3T4D4qhahR8aTIIX
 Vgn5LsP3UGUXPTh2cqL9Vu9eS0TvEZ2Wxy2TpbT+MHgloLY2xy16xG1JxYgzyA1yiwu11Pz9y
 tWFf8IxtKlh/bZAA904U/wfkE1dBxQ/CxF4amlLgqoDXsIX6PWBpAIw+QnI80E//cl/sP2161
 DaflPiah71nJSTGrATMu9MUbqxg7SijTRpF2koBG/JYmO8Oa3xQEw+q13f3Y42L/j5ZjWK4/I
 1qRGZF8EbLUDPTUXcItHNpTJ1KY47FD1WtKSFsug6SANS1AgcbuvLhCshWEd2OAMCoL+IEX6e
 pGpWuRLLvfOwA1Admrj95FEPCOzSDm9aHJQQp7PWp4boIty1rjlw/WfD+Nt9FvxZ3FnFuAwV1
 sPbJdNHNhstf42TVRf0BZTz4ZeJ5IOJFu+wNA4DzR88MR9tjyqphEF7fXnAW291DaSeTLl07K
 iFwrGMZ0VC7pDKOf8YRHLVZbamt90eEHx+hzNePbtGSwhGBTw5WcJNmc2zPDyq9PY09JWAp4o
 48eGyTEfnNzz08KUboiI09vu0L7HIadmBUuelnYFUVXgt4qe8gjwXulph52EBRvS+8kODX6W5
 hMkB9vGJ9DUQczxWJWnIwuYTNr0vCjFWVMnL4pOboGESYjPxauMUZ53vMYcBjiJzo7g8mbs9h
 TXe55jwqNQkx3yP732YQS7mQs3xQim+wpyZMisSkeF97fg+B3V/kXy1sr97FSK5w8rX7GFuMC
 EgogYkuomtugKoh9uUrIXnIDp1NqBsBCDjgmQgSINfJU94v/Scb6RIQf0fjCDlhbtGlVgi1A5
 h6p5nWKy2N/C6dLVP//iTYbK0TDtWQFtsP4wxKTi8047tzK/poZyU24Yw3mXheahDHjtEkuXj
 BW2NsieJZkkrO1Vqi+zf60TuVRi1TqwZ9Avp7APo3HBux4nmXFacb1k0gYMSbBY7F3GL4/6zQ
 bvZJH11QA0iMXVYGDXky3DKbc20df/1bZvTyXzCvbdTSTCG8rvGHdHu99Bkuh0gxXuASvTA2r
 fE2QwaXvgWjF/OHgpt7LJUl33XWZxFd2iKO4KQGGboGrnKEGY6LPQ/x2SfBt0W+DN6LKoSo6T
 CVUlhn2IEZcgWAs7iHFX1ovA/gMjYiY9ndy21Wj9FavnN82xURdcE3aPAUBGQberALQrr3bbd
 ViPXejJcdgVktmMwVYwFUSc6yeCkcg41/iuGtitoL8J9lnplOwzSTLs8/L/Y/F/pLpiuGbUof
 cUIujhNXqhL2Lwk+0fpyHWuFsmHIn53PtcPthCG8DiFEW+EtP479UHgEaHN/SVU7HcmEFphBs
 o6SiS0WgZIVI2m8SG1fOwue2kB+Q4t2B5Dqx3fHc7BBT8cKlL5am4KFRqGA1YrOqgn+WObOEj
 foFSVJFwupwL1R5prj4TfoZwSan78aAhREYKy3ELE/0pDj8XZ6llEvGX3sCZWO/sAmRUZOe29
 Kd9FGssBYkOixfrihl3Ul03/rmY0DKy6BkB4WLH54qQrhYl2C/x4GkNHG5pFZGiBWJYPD/8w5
 kta6L54406YjHZEKzf70HMBbQHYXqM1N749e7xya4nEPCksVYGxpCux9/+puH6F9DiEvo+Q6o
 FkS+4uDI8Crm5YiT3xVjCGRCDReIlSEkuCiOu9j/BHLF91EEgAy5QQ150xE1Cj1c47g00y9OB
 BkjKxjOjj5+a84g4rFCrcwg55+k+brG0+ZYCA64w6b4kYp0jv5mvuZG9CeG2UUs1vMgB5D7I0
 aGQduTYpN1EdnALQOFuv4dCMJ4F5Ong+fY3WnCiN4E87QXmqX+Fnj3xKVdp4OG4VflMgHxJDV
 71H//oddi9uaKvhIs66WUX0R5ZM4RA1wy2hJIlXEjCYOgOvizS3QeFfZ6IMCQEbKNeGIyAzgG
 NPLT5q953o/VXA2KkrrsG6DSJnjrfeppjOMMxVRGmGlrg+vY7cU3Osf9hAi5OkaJsR74xNQG6
 ijzyy0wHvXBbajwv5RyTO+IylQZDv60mZAQHIbkk09TsTUrnFsWSlWVCm7OZZ6VFyrh6QLcaU
 bFXqYLv9kylT8pIZ0lBYoZ4TSpvwsVq5RIayi/B5gaFYS4OxFTmp9JgFHxmPfNhlAvh/5upAB
 xFaeYJvYzUEyRJ0o6dthe0ukLrnMA0DnbkKcqXVZy2gy1PprQpR7/wLcERQ36m2h8fDjcXyxS
 NViS37LrJbPbsvRnoD/a1LXN3HJWlreVpWgYIc0J3sqj15zD2iWTxNAEC3Hug2mWcbTVlLHHv
 FKE1Kb/0qLKv1iCNUkR/kXrejzpl0Ze8ICeWcTCjse1Puajb0MvsIt13YlnZLesgJN4zI+sqG
 OP7ZtXTkZw0TghLYWj8/400gyMA8jZjo+U+6kpxihAukI2FnqwwENYG4ajHsXD+Ttysed+Nps
 rNS7Jm8/IXqnomyfHp2WU3JNwpA5MusiZzxGPAOgPuZK/48Rl21nvXFYguRB4DsVnpSG+15dS
 7QgrFU0WY0YwfcPryvPFKLqBO8/kjNFeGto3kFwYQfeRNLfm18uL3EdhoJDNMC53OlwTlGXLM
 zTs4P8hyHM1HdimgsXU6ijKG35r53BMYfMiHtq8qx7WiB4M7aipkNCx8wutKt4zvsO16DVIRR
 CuAwpAIDO374+AQYkHuR0sLM6OJ8AJRFhxInpsTNnc3Ghv+YwR2Se5uK6T2zwnLHlCX8XtDY6
 +Xaim0L91h9kIhCqKh9LgI6I+x8sgkogih3LDsz/atAFuOtG4I0uSPvtXWHXxKXNq4kkgBntP
 Lm3Ok5TNavQ0W77P9ZO2QbW69JKTuyQtA/wchBHXZNHce2eh8NPr+V39Aw6FrkloNVHseoR40
 72TYAZ5SQTbRBBTzF1ydQ/WJgUGwXIrBUp/A8cynZ+wBDPH/fS5zKCW/JTt1gZJCXB+RmW2aV
 cCCmYJJxTQAiPFyWint40ijbL9sCWHDzizD2qEC8lFejMh8da7An7MN46NMwCuVPqOSYr8TJV
 xF29KySqW+aHUvCoty23hcZ2EN8++uiCamj7bFSb1sZI6VhdyrO8OP8I4FexC+6txvnsrUtgd
 yCJL/JJw9GHrWPPjb1bBKyKZq5PIZynfyL5AmsoFr1OaH5hQPMu1NSUyiDnZHn/XP6aIHE/K5
 GTEZdhy3G/auzlaZnvYuvX6ik/5BK901SAtiCYI2zkn3IumHCx9XnNShKSwy/pLrcVE7uQnHJ
 ch++6NV8Y6gw1iZSw5f8p8f/Iq+kBWbmmPzAlLT0EedIsLtnbfQ9fLgbr0oCT0VOi0uc3sG1C
 8kGe6LCR+wlM87LlvURT23y6gDSSubw4NW8TwNqB+gwcLclg2YwOEsHHT6CMdz6/OlA9Tb4EX
 Q4S7R8BajO4VgxBD6xKPD+wVe65f7QJgPHTzehXTok03qqwqMFlrNvcTWRobxYuyn5vi4EnHU
 2gzjhtuvEAC2Ao7Iiao8hE+YuAo9b3JEcAXX8bPdA9qwZ60XdWJq16eJtqf9EQogNJSYwD1r3
 lOw1yqAe/eDogcRm9SNz5Rq4Iirkgvwvzi/zyP8GwbzZR38Wun9NvWAqxFip6SJdNZ4RnV3xW
 M57cvvrJBNwpVrWB3wKGldpGSM5uzlxl4Buai6xRz0zUNnX4CNrsbAHwu36n32kjtSKNgeq6o
 BJ+c8aDNlb+WKvKnu3yqlAzukwWgJjL9hakbESo0jKfipRZSrjlLgEYLskNyGSWV/r3tfID5B
 /7yTXMZ1Mp5zTbzKhvYNrOudefVJ219i4VNqHnVo8ZbJgibmH/COg60ftoIBAPMCbUAWNWgO/
 eeqGxWxc4SdDTAfAQQ/A4d6U88V6GOABrEZCPV7PIbe4K2Fk9Dc6DCDhGWXGipKy/j6CqjVvb
 /4MtmRfmtQkSGuwDMAfIw9fVPq+d67uLe3WoWlBni89hiBZ7CUScVwl4GEGXGx5obrcWufTC5
 QyHGcyJgbM2PLttod8wi3qz9NR1bLcwfocmmZkpsvDrXv2D2yX9rk3CgM+RHJbSksc4NMZZre
 FJ1Pu1VEv1eISNl0bB3lJvNf5Mv3KkKG5lfk7o
X-Rspamd-Queue-Id: 62B33238E06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6274-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,gmx.com:server fail];
	FREEMAIL_FROM(0.00)[gmx.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.843];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aros@gmx.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

When Secure Boot is enabled and kernel lockdown is active, the x86 MSR=20
driver blocks all raw MSR access from user space via `/dev/cpu/*/msr`.=20
This effectively prevents legitimate use of documented CPU power and=20
thermal management interfaces such as RAPL power limits (PL1/PL2) and=20
the TCC/TjOffset control. These registers are part of Intel=E2=80=99s=20
**publicly** documented architectural interface and have been stable=20
across many generations of processors.

As a result, under Secure Boot Linux users lose the ability to read or=20
adjust **standard** power-management controls that remain available=20
through equivalent tooling on other operating systems.

The current all-or-nothing restriction appears broader than necessary=20
for the stated goal of protecting kernel integrity. MSRs associated with=
=20
power limits and TCC offset are not privileged debugging or microcode=20
interfaces but standard hardware configuration knobs intended for=20
platform power and thermal management.

It would be useful if the kernel either allowed access to a small=20
whitelist of such documented registers under lockdown or exposed a=20
mediated kernel interface for adjusting them. Without such a mechanism,=20
Secure Boot effectively disables legitimate and widely used=20
power/thermal tuning functionality on modern Intel laptops.

Most (if not all) Intel laptops don't expose or allow to configure=20
PL1/PL2 limits in BIOS/EFI either.

This is being tracked here:=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D221192

Regards,
Artem

