Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12D3218565
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGHLBl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 07:01:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726110AbgGHLBk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jul 2020 07:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594206099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mpwcBcVOqWo2vWhK3ZHzCBKqd/c7GeCFs8iwgkkI1Y=;
        b=EE3TJ5WeC+RalkIyh1XUUWGBFOaeP5t/zclKYlyDQtC4lx/feGiGOcn0BmdeSgJh9iceWe
        vrTM07rlwI/hSx9A56hCXQjtOr6rtULXDL9KvO7YPUuOYGNNpZT3ec92oOK3meDBK7svLV
        ZEFKQYVZGW5fo2HXuGU3cOWg5k6dCek=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477--pK3brCAO2qWWS0bk_2uPg-1; Wed, 08 Jul 2020 07:01:37 -0400
X-MC-Unique: -pK3brCAO2qWWS0bk_2uPg-1
Received: by mail-ed1-f69.google.com with SMTP id m12so57395830edv.3
        for <linux-efi@vger.kernel.org>; Wed, 08 Jul 2020 04:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mpwcBcVOqWo2vWhK3ZHzCBKqd/c7GeCFs8iwgkkI1Y=;
        b=SPg/depllqIrTuIaGYdDDSQ7QK0AFM0hQgYW8IkqkctSQny6JcIAFWU2cLgZbulh7H
         Hp2vazcRW9mEQA3BiF3as+FobT5rF4R4VfeeyD8XT8iIGCfF1xqyF2jhfy4/OWTS3Vb6
         vxI3wtgHDll2modRfYh1kl45i/7PK0q23nrX7EpIUyQ/4v8nIAXxl+C7unu/IAmZOXIM
         ztwcAQOgttj2qzqZeL+Y3nQMrgex7ZILtRRSwSNPKROKS1+K0ZY6yuOuiv/6IjjCAhYi
         MGq+Xor1k39FqYc9O88BDK+/Sq2uzVgLGJPR9RDdIsuGUNUk42f1LYkQOBH2PKK2wE7k
         J3Wg==
X-Gm-Message-State: AOAM530RgrW8cKlBg0KQzBMT7mmpCuxtFCk7cPNsvJMcubX7LjaCFYw7
        BuQxkHZ1rHOMD2YUsWiKtlflQ5Lys11Opzl3Fe20ovmyTG9Ma852UrBYKTVS5hUlhzo2sjDUGhQ
        I7APnmSiqxM8NsR3Bmmfu
X-Received: by 2002:a05:6402:543:: with SMTP id i3mr45729397edx.182.1594206096306;
        Wed, 08 Jul 2020 04:01:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQYOwlXd9z9b5GX8vCI0fodR5ilbW7iNNKfVwmUo6weDMlbUb4GtDXfKFHOnZT9ZrFR1YyRw==
X-Received: by 2002:a05:6402:543:: with SMTP id i3mr45729373edx.182.1594206096112;
        Wed, 08 Jul 2020 04:01:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id dt22sm1881261ejc.104.2020.07.08.04.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:01:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] crypto: add sha256() function
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     alsa-devel@alsa-project.org, Ard Biesheuvel <ardb@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-efi@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        mptcp@lists.01.org, Tzung-Bi Shih <tzungbi@google.com>
References: <20200707185818.80177-1-ebiggers@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7b5617f4-905f-5f27-9caf-3c842cbdb0d8@redhat.com>
Date:   Wed, 8 Jul 2020 13:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707185818.80177-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 7/7/20 8:58 PM, Eric Biggers wrote:
> This series adds a function sha256() to the sha256 library so that users
> who want to compute a hash in one step can just call sha256() instead of
> sha256_init() + sha256_update() + sha256_final().
> 
> Patches 2-4 then convert some users to use it.
> 
> Eric Biggers (4):
>    crypto: lib/sha256 - add sha256() function
>    efi: use sha256() instead of open coding
>    mptcp: use sha256() instead of open coding
>    ASoC: cros_ec_codec: use sha256() instead of open coding
> 
>   drivers/firmware/efi/embedded-firmware.c |  9 +++-----
>   include/crypto/sha.h                     |  1 +
>   lib/crypto/sha256.c                      | 10 +++++++++
>   net/mptcp/crypto.c                       | 15 +++----------
>   sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
>   5 files changed, 19 insertions(+), 43 deletions(-)
> 
> 
> base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d

I've done some quick tests on this series to make sure that
the efi embedded-firmware support did not regress.
That still works fine, so this series is;

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

