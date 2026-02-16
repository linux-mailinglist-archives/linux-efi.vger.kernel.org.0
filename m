Return-Path: <linux-efi+bounces-6146-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBv/K0bokmlSzwEAu9opvQ
	(envelope-from <linux-efi+bounces-6146-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 10:49:58 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A676142113
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 10:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E36A300C9A5
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF972C08D9;
	Mon, 16 Feb 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYm5fZbC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B51284B25
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235394; cv=pass; b=OoVCYph/k0HxPsgVj8gceyNJb1cAoOmFKvx1ljNmwFhPNL6kmBnTAQOj3yaEPCh7l/bFcnlVkpZ6IU4QVM2I4qyOv/0jxp4IUlKTsCGTumrmnY4vwyvYQCDy9C24shR69jtGnTx6cYpN2O7qSJhwNW2iZBWpwDydEFj8UcLP4M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235394; c=relaxed/simple;
	bh=FzXK1f6UnWjLWPtEixlLWwC0xPTDN8h03RRzBvMQFGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2CQTNy0O/jMD8R7S8nXqBUHcYuAhVR7v3Z5Hc0CNFoikobSuziybNnNsTj2Jf5UPbVcp0GH6Y3e3Exldv2Rv4BGIeDWGjql2/pRVdg4RQj5RCPJCsJF6yHvODrENq1WH30ntJ3lOgQD8MykkoPkmOi1fJlngqoxD51q0jXpaSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YYm5fZbC; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649dbff9727so2443903d50.3
        for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 01:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771235392; cv=none;
        d=google.com; s=arc-20240605;
        b=VtCBrxBNOzaRsRm+x0NitlXD+XaW+BDOU+01nbgKzLBpG5FOtZkvic34HUNSoXsj3v
         gJwUsl5p7MCU5FVikQx0Yuc0IaVbU+KxudpvKxHoKwdbm2dL90dTAAPMVSKnIiBG+eCg
         mpsjMmUe850yi6yVd5DkIFcHlUZK59sOTc+HqCA5hLOFO5mYOym/O26dQdGPcg9iJ59k
         FnLrw7TXc9FlrCFVPMLoATwYRFbtfFpD8g+HGtFiyXc5z2GRQqbPZCUXwRuk/653SFlN
         lSY5KZ5/q32/etroWK+2X8HwEempeovbt8EHqbdWwg1WETFvZEcYc5Xf+2W13jCKXnl7
         zOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9KcAyYM/+QmM79Ib7dGqCC4dBkpE2RdJ6RsVIfszKMk=;
        fh=zTLgBf0jYama4v6/yEv7SwnSmcUKtqzpfk44E2ZELGM=;
        b=EeFNKRFgE9K2tfT19rMTmoDRSiAvub4QDdcWN26xmYB9VT8oxf2YIorLeOXe5v361/
         mj52eapPVvH4IxmYB2lErB7TCDjX2aaMvTPcQY37/v3uB0lgi45MblcWfbYcyszWqpX3
         YqfL8b70VHuRp7kLyNO4gaui8CCH3bBx2KndHyb2iDYa2h+9ldd/Xo1e1BxCQn4mWWu1
         Wr3FBZ86jkQb0kY1G6F/1/ICjH+c15Ctsiyy6oqhDMJOlx2dKVF8038OrJezXp61xnZ4
         wBmjCMeNGRpA59YgORZ3nIEHzQuDnOJz/M3SGnKUWIdPeTIxC9NPWIU1EPzyX+hgWI4E
         akWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771235392; x=1771840192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9KcAyYM/+QmM79Ib7dGqCC4dBkpE2RdJ6RsVIfszKMk=;
        b=YYm5fZbCg0l1+zRFlFHO0cVoxkU9DythHCl9ir04tl9K7Ww7A3ojK5WbKIyqqyZJg0
         axg7ee6C64j6IVSYmvE1/oLwuDiQf5jrATMn2no4bmn56wejKuCPD6/OIJUvl5ZR3NS7
         Ps4Btr4emqP5JJxg/CMyjsAKK/OTzRE37GS2a4k7OCpKHMlNKdZrf9WMBdYZcIVlKDVL
         xu0TmZjtYxHKVNghvaOPkQGAYiif0Sz3QnxhChFsW/EnoCvkdzIGBZcNveNPKyQ9sKnP
         CSaKtNf0gg6ojwK89BDYmSDXLfZKiP6b63OGk9r/CHqmUW5GUYLsynxVKGlZaxxrA0DA
         UGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771235392; x=1771840192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KcAyYM/+QmM79Ib7dGqCC4dBkpE2RdJ6RsVIfszKMk=;
        b=xCHpLup1xdmj7Xlt7F0bFwlKXgKRoCSTb6u1dtz7r91V9B0yGI56y9O6ipPMZDdyq3
         MrcXn/LRDk4y7qARyXZ3BFjcp6BG/mmqcuuxNz509+Zf/dMijvQ8j7XA/WsjqpJ1Mp9j
         SOLcSY/26wZolvBtkM/Qbm5hhMbwSDeXUm71Y7zrVoGx1xfi0eAYnfAscBBpaup5y2jK
         Yi1RpGRALhv+SP69EvyHqbqwWiFE+x/8wHywg0lIq5xsFXrmDr4nHb9MoHl3mu3p3A+v
         nsTGxplgL0pvTjoQ/HCERIjmF6gyqZrzVIODTuzCsruoLAnLos0mc8wG4jzqaI+4sPwU
         XD8w==
X-Forwarded-Encrypted: i=1; AJvYcCUlu5sy1eEyI8U/NP9t1YmdnqOXt0LXHrvGZKFa/VlmKPw+OmCq7GyxTa0MGmEArYVf9pD5DTVtbmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKf2XipeWGTmZtKpzzJVVWyTA4VgTZigz901bP26fI++qkWWX
	nEwHFHQHgDcHoSx7dGEBkh4qCjvUqVgtjKu2ZA+u6LIRmB6KG0FEqHFUpB9X0jwNIqGvAqkjF9I
	NROgHaDKeSS4bc0qcWXK2aty3Rsp/2s5p+AitrMKIZQ==
X-Gm-Gg: AZuq6aKkf92E8Rf0RzXUyI0758T7N8TiAnxOAZXwR/S1nNxHe/B4fTx9NDNLoHnu2/m
	z5BFQglWl2wvkhGpg6DGN70d7TEHvDbJ8/90TlEkSInss+Gip2B440hWnjJkIKrvXV9QTHupGQL
	hYCcOHm5o7ftXKYo5uPuaHMOFk0MoyeBrNwv5YOiswNvBg+eok8WVkeNXYMmmLqW0MoCCO7wCMR
	/wYtVuA+FVsElIGDvrBEGpAQDDQjXt1WYsSQ6Ms2QCef0RwaIGhu7g9kmPPuTAfUEeWJvLz7tmW
	Iy6Lr4SxQiAMtLzyCwkAgJ7DOem2+Ts9XvM6LDAD3SpjD6cvYjoN6RMoWXyDx/eMLYR+19QmjL1
	6Fj6Jt6eiO+PwLvqe/MzcwkWntXfuFo5iOoRM3t8FnKoCGma2TjJ0Sot4tcfEQtJ1hkL9ST5xpt
	kKCRRywPt9YeSAr38KKsUTjH/gA/O/jXhX56A946rQVd21fkXF0jG6W2DT9rMq2X2hyuMJ3ARnt
	mVj6anNRw5g9gFkPZJCoOWJb9gpTcVuMdBySqpbEs3t/QFTieXmPQWz8NSwtuzIygdFc6Ev45ia
	FI/3oP+w3O4pG77AksW2718x4+xJZeNJPNEJ8ENKpguP
X-Received: by 2002:a05:690e:1503:b0:649:44ac:cc01 with SMTP id
 956f58d0204a3-64c21b18a02mr5405053d50.55.1771235392354; Mon, 16 Feb 2026
 01:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Feb 2026 11:49:16 +0200
X-Gm-Features: AZwV_QiWccMZyM72m_4_u3dE4MCMJlyOZRCqnU7JaUjXWUFD4VNEgOXyE-7aI8E
Message-ID: <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com>
Subject: Re: [PATCH] efi: stmm: Constify struct efivar_operations
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-efi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6146-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A676142113
X-Rspamd-Action: no action

Hi Krzysztof,

On Sun, 15 Feb 2026 at 13:06, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> The 'struct efivar_operations' is not modified by the driver after
> initialization, so it should follow typical practice of being static
> const for increased code safety and readability.

get_maintainers doesn't include me in the cc list?

>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index 7b04dd649629..3bea2ef50ef3 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -14,7 +14,6 @@
>  #include "mm_communication.h"
>
>  static struct efivars tee_efivars;
> -static struct efivar_operations tee_efivar_ops;
>
>  static size_t max_buffer_size; /* comm + var + func + data */
>  static size_t max_payload_size; /* func + data */
> @@ -520,6 +519,15 @@ static void tee_stmm_restore_efivars_generic_ops(void)
>         efivars_generic_ops_register();
>  }
>
> +static const struct efivar_operations tee_efivar_ops = {
> +       .get_variable                   = tee_get_variable,
> +       .get_next_variable              = tee_get_next_variable,
> +       .set_variable                   = tee_set_variable,
> +       .set_variable_nonblocking       = tee_set_variable_nonblocking,
> +       .query_variable_store           = efi_query_variable_store,
> +       .query_variable_info            = tee_query_variable_info,
> +};
> +
>  static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
>  {
>         struct device *dev = &tee_dev->dev;
> @@ -558,13 +566,6 @@ static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
>                           MM_VARIABLE_COMMUNICATE_SIZE +
>                           max_payload_size;
>
> -       tee_efivar_ops.get_variable             = tee_get_variable;
> -       tee_efivar_ops.get_next_variable        = tee_get_next_variable;
> -       tee_efivar_ops.set_variable             = tee_set_variable;
> -       tee_efivar_ops.set_variable_nonblocking = tee_set_variable_nonblocking;
> -       tee_efivar_ops.query_variable_store     = efi_query_variable_store;
> -       tee_efivar_ops.query_variable_info      = tee_query_variable_info;
> -
>         efivars_generic_ops_unregister();
>         pr_info("Using TEE-based EFI runtime variable services\n");
>         efivars_register(&tee_efivars, &tee_efivar_ops);
> --
> 2.51.0
>
>

