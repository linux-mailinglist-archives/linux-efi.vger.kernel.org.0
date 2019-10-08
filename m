Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6CCFE0E
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJHPrv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 11:47:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbfJHPrv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Oct 2019 11:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570549670;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBGvZIF571HTn35++5kc9Le27q5+H0WDHt3Pl1cs/as=;
        b=Q73LJbA9Re3Ma7n37SM2TcFzS3TagfnqVizO4++oVy4Ic5nGn6G70hErZDUyYJDKuGXXeQ
        jtDEbx2paahJFgkJ+z5f5zAkPO9rO53p9xa0KSq9URCz3V4usqgNjSZeJS6WQ6Ou5qUJXE
        Wc3+W9w0UXe73AJMXVu3GXlVC0wOaPA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-vWRI35EENY6AWk4mTNiwTw-1; Tue, 08 Oct 2019 11:47:47 -0400
Received: by mail-io1-f70.google.com with SMTP id f9so33626084ioh.6
        for <linux-efi@vger.kernel.org>; Tue, 08 Oct 2019 08:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=numh0AsMF/f6J8tPWFvYvdNcl71ucF4WJz8Q0cwIn1c=;
        b=lst53RylvZv+MyBoRzZR+MvLZNbCPp55fJDSMZV44G35A9RraAGUnX6dVdUu9qKXNe
         B1JNnw7oKOyaJ687XE+c74CSGJB6y/jznGK6Proxn9ZP3mH5ec/HkTVKUo+m/Ee3s7qP
         /Z6rtwoziMm18CEQ9kx7BztKI5beDLJGGK3iN1n8zX3JOwwdgTI7DSythSBdrjHxpb+u
         QZV1cAlqfmoX2QCGGvVblhSn8hz6ftD1AqGkf1uQVd+uuEmX8M3wewmq4K/7pDkjoj4T
         IYphODgXdpFhMVyyduayt8dqBEm1SD43fgBfFF+mbk+6WdOpbHPcH2ug9Uxnx2xPCZEr
         flcg==
X-Gm-Message-State: APjAAAX0xiH2CAYYSTjcH5e6cKiogeDAqp7OSss8u0c7y9+rO/RZBr9D
        vo85ISQbGIHi7cK1+nLhpXeS04bSsloaCqHt5b7JHS/FyXM+bfHkq9el0KYh6d+RIme1RDUO2zJ
        AnSTn6FxbgJMu6SZ0gZ2+
X-Received: by 2002:a92:d952:: with SMTP id l18mr37425755ilq.114.1570549666760;
        Tue, 08 Oct 2019 08:47:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwR4ZSdz58d23xVxIvLtsUUAjcUQrAZZO2o0ImYt67YaZe8YDlXpEc0cdZFhuDDzD96j/KSYg==
X-Received: by 2002:a92:d952:: with SMTP id l18mr37425730ilq.114.1570549666524;
        Tue, 08 Oct 2019 08:47:46 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d6sm6549608iop.34.2019.10.08.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:47:45 -0700 (PDT)
Date:   Tue, 8 Oct 2019 08:47:44 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] efi/tpm: fix sanity check of unsigned tbl_size
 being less than zero
Message-ID: <20191008154744.c3ppu63cbhg5kr7q@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191008100153.8499-1-colin.king@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20191008100153.8499-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: vWRI35EENY6AWk4mTNiwTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue Oct 08 19, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>Currently the check for tbl_size being less than zero is always false
>because tbl_size is unsigned. Fix this by making it a signed int.
>
>Addresses-Coverity: ("Unsigned compared against 0")
>Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after suc=
cessful event log parsing")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> drivers/firmware/efi/tpm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>index 703469c1ab8e..ebd7977653a8 100644
>--- a/drivers/firmware/efi/tpm.c
>+++ b/drivers/firmware/efi/tpm.c
>@@ -40,7 +40,7 @@ int __init efi_tpm_eventlog_init(void)
> {
> =09struct linux_efi_tpm_eventlog *log_tbl;
> =09struct efi_tcg2_final_events_table *final_tbl;
>-=09unsigned int tbl_size;
>+=09int tbl_size;
> =09int ret =3D 0;
>
> =09if (efi.tpm_log =3D=3D EFI_INVALID_TABLE_ADDR) {
>--=20
>2.20.1
>

Thanks for catching that. Somehow I dropped it from v2 to v3.

