Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24DC6F9061
	for <lists+linux-efi@lfdr.de>; Sat,  6 May 2023 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEFH4s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 May 2023 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFH4i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 May 2023 03:56:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129339ED5;
        Sat,  6 May 2023 00:56:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6434e65d808so2913123b3a.3;
        Sat, 06 May 2023 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683359797; x=1685951797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSXqKKL2DM5ohMjcHFVamqTpkCqxvyAHPkfC2Zw2f2Y=;
        b=ICQZu93FaTdOWK1lWtPwQ6fV3se+udSFcWL+PX02WV5hmUCuWM1vm69LM2Ew0WtkAG
         AYwB/VBtO9q9nBrGgXxxp/P7t4YJjwxxloHfy+W2rj6QtoooYwfzSw4FG30PhManLORX
         Dobl3L47/V0W4e3uq5DXNhAonfv5CuHhePYN2W1AWFVaSOSJpcLz0TP09p6VUgCRl5nE
         WtzDFfac+YTPQ4y17OXd+J/Kv7YF4lyiR+QElUsHM/w6FjjThXGnbkK74JFI9fJtNEfZ
         KSnk6rzR6p0+/iN64StLdRR4o5D9Z9HMDD4Q9H3y+lIKkXnFm1GJftui1DejIzFwB1OQ
         A9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683359797; x=1685951797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSXqKKL2DM5ohMjcHFVamqTpkCqxvyAHPkfC2Zw2f2Y=;
        b=GN0fS0s9KRfj9T6ECCJHv3qe5tjnM7wK8lGM0BG2Fie2tRoFauOGvxgHGc2Uxw8Gf9
         Tus5arpXfKpJazGAKceJbRB7x/x0xU7l0pYB/UoCEeSCK8RE4fz3AZpUFzxrPpfthGS/
         qm+uzXoe59qnrzY+Rkd04UkmaAYpcvsgPB0mN7BR7ygbs41qw02AdnMsCeVnUuVvdz0o
         jQDkJfGjKdiLzn4GM02e0AkBgULhL6Jx+wpdIEgdhYJs1E02rec/lK9bgDRZwGffNv8I
         5jpgnZtOGwEgb5S+5P9ZkCP7fhl2szuOZq9haV0URNDqN7xGU3TVhK7WpQPUuw35sXMo
         Icsw==
X-Gm-Message-State: AC+VfDwK88u+16Q9HHmwHvJtnV2Favgjag+WriqoQ1MRIjw3epB1fUMQ
        phke0VXsoYqRGcVtH9B5fdI=
X-Google-Smtp-Source: ACHHUZ4RWbkiR7mdDfiHmHp/BQEz0RuV+uOOFyLTWkWCNB+y/nFFtdZpPV2V1ex8dOzmoZa/+razmA==
X-Received: by 2002:a05:6a00:1483:b0:63b:89a9:529f with SMTP id v3-20020a056a00148300b0063b89a9529fmr5038706pfu.14.1683359797435;
        Sat, 06 May 2023 00:56:37 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id e19-20020aa78253000000b0063b96574b8bsm2648811pfn.220.2023.05.06.00.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 00:56:37 -0700 (PDT)
Message-ID: <0f62ff02-f601-e629-6524-972441035129@gmail.com>
Date:   Sat, 6 May 2023 14:56:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Content-Language: en-US
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <ZFTA0kg98XxeP2Hh@debian.me>
 <765a94ac-ed2c-267d-0ee9-be21757ceb16@oracle.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <765a94ac-ed2c-267d-0ee9-be21757ceb16@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 22:45, Ross Philipson wrote:
> Sorry about that. In the future I will include a base-commit field. It is based off of torvolds/master as of 5/1/2023. The branch where the patches came from is now pushed to the TrenchBoot repository here:
> 
> https://github.com/TrenchBoot/linux/tree/linux-sl-master-5-1-23-v6
> 

Pulled, thanks!

-- 
An old man doll... just what I always wanted! - Clara

