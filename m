Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB749F368
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 07:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346317AbiA1GRc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 01:17:32 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33876
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346323AbiA1GRb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jan 2022 01:17:31 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A73A23FFFC
        for <linux-efi@vger.kernel.org>; Fri, 28 Jan 2022 06:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643350649;
        bh=0t1V4zvmNPJT9wYj/Pd8jJat58ip8FOEKuqF28wuRD4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZdRus7QXPg/hqA9G2jvpSG/r/zc6jMY5EGxTTQOBJloYK+B9F0xYEUB53amld8ozu
         gLFE7WqZqWLkpRwXqq7QFM5GIc/Tl5HrglZ+UZ7FTwVm/F8wsn84pfVgnPZR6q+s9k
         7CB+M95rKFndO37/H8U4E0Zr1YlS9yms7nONaZKTmgUVDaHQ4IHGw5/0aGw73nZkDY
         WEJH51NAS+q0WgbBa9QMlVITWzB9HTXFzXfPNgvOhDx7XjORgGWU067KUNLXwrOQhh
         +7Rfh8m1Q/7YVevZ00nej/oeDGbbAyR09jP++VkcShoH4k+wLgEpavzGnBGyOxgt52
         QyZg9dEhT2vYg==
Received: by mail-wr1-f69.google.com with SMTP id c9-20020adfa709000000b001dde29c3202so1850827wrd.22
        for <linux-efi@vger.kernel.org>; Thu, 27 Jan 2022 22:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0t1V4zvmNPJT9wYj/Pd8jJat58ip8FOEKuqF28wuRD4=;
        b=XbX3GSbOqBhdsvvGZ2kDJXXcp4cj0ZJK3eTN1yA75YiDY0cEAXtHgnjNPVSGmbPVyW
         5cMJnVcOZSFI9jxUdfnNUBx2blJo6caHA3yQHrFUQtAV9zL7DQst7BSox9rV9+rGpL2W
         EPkSqQ6wpX+ZcmdsNEWmwubt4xOteTuRSDi+HikNjOP7jbcVSrsSDNJEZ1DpOdk0GjS/
         AiUaCKdblaTmD/3HEAb4f0tTn2jbzSdOq+24WTDoQJBZVHEn4HQ0XF4dBPaolaKFiFKk
         xDNYLCJClmgMHKWu9Vek2w4XdZUrK8quYSs8SrtHMVwGfMAEF0VeFltP9BL0wbL51pUV
         PTBg==
X-Gm-Message-State: AOAM531rFvH6p5Bji8oTLXn6PsDv4W3vQ92yDQGSLJrKoAwBsdsXQhSi
        Hz2+iB8J5WIheImdRLl+9/eASwYCG/SAZS+Q017CZ72uP+enaCgxOgLPIqJAAn0QSZLav+DJLQI
        lqdoF2ZH5sMp8tuHZB6MEszelrAgmZXfW+sPL2w==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr5875248wrr.220.1643350649352;
        Thu, 27 Jan 2022 22:17:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnfGoUTSgGUq+FTJ1O5uTS7OjWZEbG246bwyKtGG3BSFUg0GOMLfkbUl4tx/4Z1J+yMAiWqg==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr5875223wrr.220.1643350649139;
        Thu, 27 Jan 2022 22:17:29 -0800 (PST)
Received: from [192.168.123.94] (ip-088-152-144-107.um26.pools.vodafone-ip.de. [88.152.144.107])
        by smtp.gmail.com with ESMTPSA id m6sm1158698wmq.6.2022.01.27.22.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 22:17:28 -0800 (PST)
Message-ID: <6cd57022-6fe3-d065-dbe3-e9487894a94c@canonical.com>
Date:   Fri, 28 Jan 2022 07:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] riscv/efi_stub: Fix get_boot_hartid_from_fdt() return
 value
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        stable@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220128045004.4843-1-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220128045004.4843-1-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/28/22 05:50, Sunil V L wrote:
> The get_boot_hartid_from_fdt() function currently returns U32_MAX
> for failure case which is not correct because U32_MAX is a valid
> hartid value. This patch fixes the issue by returning error code.
> 
> Fixes: d7071743db31 ("RISC-V: Add EFI stub support.")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
