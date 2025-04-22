Return-Path: <linux-efi+bounces-3411-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C909A96E50
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA60017B25D
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF4284B2E;
	Tue, 22 Apr 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="DDekHAzm";
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="DDekHAzm"
X-Original-To: linux-efi@vger.kernel.org
Received: from gmmr-3.centrum.cz (gmmr-3.centrum.cz [46.255.225.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CF2836A2;
	Tue, 22 Apr 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.225.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331936; cv=none; b=TWD6kHaYhR/4f6Lzh1yl5enGxnevv1g2tJYIpEoZQxa/2BLFee0FyY1AuFCd5hrD+LKJx22JNYe4EuH0F8cB/sP2Yo53gqre5as4gwoW3HN5AHTamuUO3g5M04nPboCEqk1APti8gSxsS24qktCI8sZ6B5yO09I4WrqbTJCae78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331936; c=relaxed/simple;
	bh=ntkJe7TPmlittl3311QFLzS6pqgnTuAgm8M62fNllsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+dF0/tUyQypLibeT6QpoAW/PKWY6YbYLaQQa2PRUYq2z5YVKxuQfjVNY7y+9uZijHPeLv+OLp1500vg4iGIAQEtUAu6IXTYEcvbrgOmdac9Qx3wtuqNupNrHmsm+tvzzLln90EuHH8SKVFRuVTdL7yuK52bkkuf5aXhPxHw7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=DDekHAzm; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=DDekHAzm; arc=none smtp.client-ip=46.255.225.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-1.centrum.cz (envoy-stl.cent [10.32.56.18])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 128AC20CD134;
	Tue, 22 Apr 2025 16:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1745331849; bh=ntkJe7TPmlittl3311QFLzS6pqgnTuAgm8M62fNllsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDekHAzmHg0jYfs8Qu1HZVjjHboVGbasYc9La0Yo7JD1vFfdT3oqGSnhb7oqz1IYb
	 6ZRSj8RrHYECM+0YrvQg9bCXXaeWubUskaxB9xwcwVw2co/Bwps1dVZ6gRezk+HUB7
	 /5e6klYMOkjWwCMt/WF3BlYtztnhWGlB+mD3pYZc=
Received: from gmmr-1.centrum.cz (localhost [127.0.0.1])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 0F9381A4;
	Tue, 22 Apr 2025 16:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1745331849; bh=ntkJe7TPmlittl3311QFLzS6pqgnTuAgm8M62fNllsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDekHAzmHg0jYfs8Qu1HZVjjHboVGbasYc9La0Yo7JD1vFfdT3oqGSnhb7oqz1IYb
	 6ZRSj8RrHYECM+0YrvQg9bCXXaeWubUskaxB9xwcwVw2co/Bwps1dVZ6gRezk+HUB7
	 /5e6klYMOkjWwCMt/WF3BlYtztnhWGlB+mD3pYZc=
Received: from antispam35.centrum.cz (antispam35.cent [10.30.208.35])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 02D3539F;
	Tue, 22 Apr 2025 16:24:09 +0200 (CEST)
X-CSE-ConnectionGUID: W82gRpqDR4qZQmSA4Y3WeQ==
X-CSE-MsgGUID: ngvzNfCjT6W0QtU5pwErLg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EHAAAGpQdo/0vj/y5aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFJgTgCAQEBAQELAQGDP4FkhFWRcQOSKYEgikqBfggHA?=
 =?us-ascii?q?QEBAQEBAQEBBAU7CQQBAQMEOIRIAosuJzYHDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEGAQEBAQEBBgYBAoEdhTVGDUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QINfgEFI1YQCw0BCioCAlYGE4MCAYIvAQMxFAawLoEyGgJlg2xB2EMCSQVVY?=
 =?us-ascii?q?4EaCgaBSQGBV4Z4AYFbhBGEd0KCDYQ/PoJKFwSFOYJpBIItgReTQYUCiRVSg?=
 =?us-ascii?q?RcDWSwBVRMXCwcFgSlDA4EPI04FMB2BeoNuhTWCEYFcAwMiAYMTdxyEaIRSL?=
 =?us-ascii?q?U+DL4IDaB1AAwttPTcUGwaWExImgSqBJYQUYAEHQRYCIIEtDZcxsAyDHIEJh?=
 =?us-ascii?q?E6HS5VKM5dwA5JkLphQjA2BeZsvgVAeC4FxDAczIjCDIhIBPxmXQ7xodgIBO?=
 =?us-ascii?q?QIHAQoBAQMJgjuLboFzgUsBAQ?=
IronPort-PHdr: A9a23:sBEl3xRw47+gidhX6cRRcBfs59psosqZAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSB8ODs7ke17GH7+jJYi8p39WoiDg6aptCVhsI2409vjcLJ4qoL3O+B9PRKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAvPusUMnYduNqk9xgXGr3ZGf+lbyn5jKE6OkRr7+sq/85lv/jhKtfk87cBAS6L6f6o5T
 bxcEjsrNn0+6dPouxfeUwaB/2MQXGoOnBVHGgTI8h70UIrpviT1quRy1i+aPdbrTb8vQjSt8
 71rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSGFfQsheSTBOAoKkb
 4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOm3T437A10/45HA/I3AIuAcwDvmnXotX7O6gdT
 f26w6vTwDXMc/9bwy3w5JTUfh0jp/yHQLJ+cdDWyUkqDw7LlEufqZD/PziI2esCqW6b6vRjV
 emyjGMosRtxoju1yccpkIbJnJkYxUrY9SV92ok1Pse0R1J6YNO9FpZbqi6VOZdsTMw4X2Fop
 Dg1yqcAuZOjfCYG1pQpygLcZvGGbYSF4BDuWfieLDtlhHxoeLyyiRiu/UWiyuDxSNS43VlJo
 yZbjtXBsnAA2hLR58WIVvZw+kGs0iuB2QDU7+FLO0E0lazDJp4i3LEwjJwTvlrHHiPsn0X2l
 qCWe0M58ear8+Tqerrrq56GO4NqigzzMr4iltKhDek6KAQDXWiW9fyi2LH+80D1WqtGguMqn
 qXDrpzXKtgXqrS9DgJU1Iso9gyxAC280NsCmHkKNFdFeBWagIf3I1zOO/X4Deung1SrjTdr2
 +jKPr3/DZXJKXjOiLjhfbNk505HzQoz0chf649JBr0bPP38REnxtMDCDh8kNgy42froCdRl2
 oMfX2KAHLOZPbvdvFKJ/O4jPemBaY8PtDrjNfQo5eTigH05lFMFeKmmx5oXaHS2HvR8JEWZZ
 GLhjc0bEWcJpAU+SfbliEeZXDFJe3ayW7gz5iohBI26DIbPXpqtj6CZ3CenAp1WYXhLBUuUE
 XrzbYqEX/YMZzyUIsJiiDALSKauR5c71R6yrA/616ZnLu3M9y0Aq53jyMZ65/fSlBwp9Dx0C
 cqd03uXQG5pgGwHXSI50Lp4oUxnxVePybJ4jOBAFdxP+/NJVR83OoTGz+NnEN//QQHBccmTS
 FagXNqmBSs9TtUrw98Be0p9Acmtjgjf3yq2BL8Yj7iLBIEo8qLbxHXxJNhyy2zA1KY/i1kqW
 MxPNXephqJn7QjcG5bJk1mFl6atbakd0y3A+WaYwGqNok5YSghwXrvBXXwFYUvWt9v56lvYT
 7CyEbQnLhdBycmaJ6tWZd3piVpHSeznONTfZWKxhnuwBQyPxrOKbYrrdH8R0zjDB0QciQAc4
 W6GNRQiBiemu2/RESZhFUzxbE/28elxsnW7TlQqwAGMdEBh07u1+hgIhf2TUf8T37QEuDs/p
 DVwBlqyw9XWC9+Yqwp7YKpcec894EtA1W/Bsgx9P5qgL69lhlMFaQR4oV7h1xVtBYVci8Qls
 HQqzA8hYZ6fhXFceimX0Ja4FafQMXK6qBKgcanNwXnFzc2bvKwI7aJrhU/kuVSRG1Y4u0tu1
 XpWmy+V/JbDCQMIeZvtVk8ssRNo8eKJKhIh7p/ZgCU/eZK/tSXPjpdwXLNN9w==
IronPort-Data: A9a23:kWS9x6ozvBqOBz3JwWpjblZx6z5eBmIDZRIvgKrLsJaIsI4StFGz/
 9cnaN20SrzTNTykP5w0PZPnthk2DaWlyIcwQAZr/n9jFH8S8cTLXY3FIkysb3rCI5HKRx9us
 5RDN9fNJ8pqFS+Mqxn9Y+ftpnIjiqrZHOKiUeTNZXkhFWeIJMtZZTdLwobV1aY42oPR73qxh
 O7PT+3j1H6N1TMkb2tLuvmP+Eo14v/85mtE5QQwa61CtQ+EzyVFXJs2KPDqJRMUYGX18s1W5
 Qrn5Ovklo8M1051UrtJqp6iLwtXBOeUZVXT4pZvc/DKqgBYoSAv2boMOvMZaENG4x2EhNkZJ
 O9l7PRcci93ePSR8Aghe0MASXwmYfccoOKvzUWX6KR/8WWXLhMA/N0xVCnaDaVAks5rDGdH8
 +AvKTxlRnirm+KszbunffJnj8IlIdODFNt3VqZIkFk1pd5/KXzya/2iCe1whV/ctegSdRrqX
 Pf1XBI0BPj2S0YWZgpIUsJWcNCA3RETexUAwL6cSDFeD2L7lGSd25C1WDbZl0DjqWy4US90q
 0qfl1kVDC32O/SgmWCKyGq1qtWThBHCXbk7SIzjyfNT1Qj7Kmw7UHX6VHO0pLyij1KmAosZI
 EES5jAzqO455iRHTPGhAVvi/SPC5ERDHYUNewE5wFjlJq786hyaD20NVBZIdNgvr4k9V1TG0
 3fQxoi4W2Qx7uf9pXS18LiKvxW8Eiopc1BaXDM5EBMazsPHr9Rm5v7IZpM5eEKvtfX/ARn5x
 zGHqnh4i7h7pdYGy6ih73jGhTy2r5TERwJz4R/YNkqs9A9zTI2ofYql7R7c9/koBIKEUl6pv
 3UencWaqucUAvmlhHzTaOYABrek47CCKjK0qUJgG4kJ8zWr5mK5eoZR8HdyKS9BPs8adHnpa
 UnItAV54J5VIWvsbKlrbob3AMMvpYDlFNLqUdjOY9ZOa4Q3fwiClAlsalSXxHvFi1U3nOc0P
 pLzWcKtC2sKTKlpzRKoSOoHl7wm3CYzwSXUX5+T5xCm16eOIX2YU7EINHOQYe0jqqCJugPY9
 5BYLcTi4w5DWef6bwHJ/oMJa1MHN342AdbxscM/Xu6bKyJ0CX0mEbnaxrZJRmB+t/gL0L2Vo
 zfnABAelweXaWD7FDhmo0tLMNvHNauTZ1prVcDwFT5EA0QeXLs=
IronPort-HdrOrdr: A9a23:S2q1QqAh9R+p9GXlHem755DYdb4zR+YMi2TDGXofdfVwSL38qy
 nOpoV46faaslwssR0b9OxofZPwJU80lqQFgrX5X43CYOCOggLBR72Kr7GD/9SKIUPDH4BmuZ
 tdTw==
X-Talos-CUID: =?us-ascii?q?9a23=3AGqY2J2tb6gtzT0nJOTf7dSxr6IsaIifS9m/JD3X?=
 =?us-ascii?q?kEFRQTYa8FW7Lx65dxp8=3D?=
X-Talos-MUID: 9a23:Gs+txQu0CRSK/WPGg82ngj58JuFmyKaSVn9VqIk75tGbGDZUNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,231,1739833200"; 
   d="asc'?scan'208";a="113960662"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam35.centrum.cz with ESMTP; 22 Apr 2025 16:24:07 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id DFC70100AE2A3;
	Tue, 22 Apr 2025 16:24:06 +0200 (CEST)
Date: Tue, 22 Apr 2025 16:24:04 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/mm: fix _pgd_alloc() for Xen PV mode
Message-ID: <202542214244-aAemhFXr07MuvPSN-arkamar@atlas.cz>
References: <20250422131717.25724-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sgx7kSU8nAdjTHV/"
Content-Disposition: inline
In-Reply-To: <20250422131717.25724-1-jgross@suse.com>


--sgx7kSU8nAdjTHV/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 03:17:17PM +0200, Juergen Gross wrote:
> Recently _pgd_alloc() was switched from using __get_free_pages() to
> pagetable_alloc_noprof(), which might return a compound page in case
> the allocation order is larger than 0.
>=20
> On x86 this will be the case if CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
> is set, even if PTI has been disabled at runtime.
>=20
> When running as a Xen PV guest (this will always disable PTI), using
> a compound page for a PGD will result in VM_BUG_ON_PGFLAGS being
> triggered when the Xen code tries to pin the PGD.
>=20
> Fix the Xen issue together with the not needed 8k allocation for a
> PGD with PTI disabled by replacing PGD_ALLOCATION_ORDER with an
> inline helper returning the needed order for PGD allocations.
>=20
> Reported-by: Petr Van=C4=9Bk <arkamar@atlas.cz>
> Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,=
free}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - use pgd_allocation_order() instead of PGD_ALLOCATION_ORDER (Dave Hansen)

The patch fixes the reported issue. The following trailers can be
appended to the commit message (as per [1]):

Closes: https://lore.kernel.org/lkml/202541612720-Z_-deOZTOztMXHBh-arkamar@=
atlas.cz/
Tested-by: Petr Van=C4=9Bk <arkamar@atlas.cz>

Cheers,
Petr

[1] https://docs.kernel.org/process/5.Posting.html#patch-formatting-and-cha=
ngelogs

--sgx7kSU8nAdjTHV/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEoDIFP/dmMcxNFBW7NR2RttffnlAFAmgHpoQACgkQNR2Rttff
nlDEew/4yEcCR71HSRxIJ7TyGxMDt7CdIFdUbwnVZ/+Rc3rwRz8DV+MNxmMLO7n0
6vKNXqBIn9sy57f1YM0DyS8X0n6bywVFcjYwPPlEA/iCG2bCZ1G4amMmd9vFoMNq
MAR03chHi/s0kWLuY6MqtIQpvD0q6dXgWjtiuC5l7U2GbMo6WQkwmozB+UalK+oB
/z067SzsGCg/3dx/+78B7EHheRBr0oQYSOteyD5+LmdbgJT0q+73Hz+jbvjodtku
Bbf1NDijqkjbHE7mct5C4o1DLWRnqe0oHOj6xP4FxLg0nRd4vc4ts+E0JMfTifql
e3BsEhbqyWSeLxPypM2d6tbV04yeUigLohaDVFbdSOJKM7Yf0PLP5QieaRYeQHt/
3AL6TBM9kTtHoFlXELwKz8aXYe02zZ33R/xQLsND34gVB0YC1BgWRF/VCSq/NBDT
qFXoZpf5XNm1xeUtnU4W0LM6wLodPbR7aFwsE5gGz2IMc/KHIBQvIzWottAeAf95
cCLbNrIMqbP4aqN3K8kE6HjwjPqP/F0WjFK7VwbAM/UxfyGPQP2MIeVRLQi9/56g
tKew1Ze6WKsDkUeKd5AdbFPkOvpKeg/4Q+RCmR/qLx5DwJVUurjDw72rePGP0D6c
T9xIlZqLrLtfp9SiHAqpUVU8S4Fy92U7drx0TdyelvUVgAvWbw==
=ZGj5
-----END PGP SIGNATURE-----

--sgx7kSU8nAdjTHV/--

