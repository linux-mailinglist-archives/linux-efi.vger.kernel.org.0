Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416726BD86E
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCPS5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCPS5c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 14:57:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B7DCF45
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 11:57:29 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4D82B3F0E1
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678993047;
        bh=QxqRs/KWG5HAcPHMQaRj+RAjvJydpfqD9+moSKVBklM=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=oFCwnPlkEf6Bs+yLtye5OnooYqacOzsecoJ+2AJTUHVwTA24uY5cSuyJbiWWrSdcp
         AlBZQAX0DGy/p+pTl+IDQ7G8JbBMQiYbTq32ypByG5K+QPoc3HMuvs+6dMIMneqw4v
         2GmRURklMlr+yJ327HimhX1J4VslG0C0g8y+HXEAoq1YMPpHHUBkO0GYcPVsSm/MK2
         Ks7Jc0EDnvlEChQZPR17V7fqtfde5AlrY4qA5Xd2NgzFRuPNxQioCPKy1ZdGJ0P1nJ
         BhAKKM03IQNcdPma4dA5kOpTNaLvTee/dOWyKGL0wtkb6jJ0rRcUFTOo+h232d9v0o
         4M1CjELehkz0A==
Received: by mail-ed1-f69.google.com with SMTP id i22-20020a05640242d600b004f5962985f4so4395070edc.12
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 11:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678993047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxqRs/KWG5HAcPHMQaRj+RAjvJydpfqD9+moSKVBklM=;
        b=PclSJ3g3md8quyBYozjNkFd5LLs1x7nzk3ye/VqWGXfSXjyA8OyUNqdEnjhX6u5wNU
         Ma7DgfImxvDSjcFXfysQaqR5yEZAFNnJsYY60F7BHkJKff14HnliXvilj45MCoCUerHY
         ykb1qNXYYghZmiMmXTgICLA110FJpafHdtu6EVOGo4iAe0KVLPPmGI7iKbxvPkPRICED
         PObs62CqYlw3SFTStLbd0jNcLeoLJRxzmA0iAqL5Kzo7yH7Gn+RvFht50YAywSx0oxS9
         U3XNZesECx24ZbNMpzh2iq78XeQbLovoHdwL90nuiKh2lgcCqiLhoR7h3SkAd8DyKBc1
         kj2Q==
X-Gm-Message-State: AO0yUKVQH7dBpwblnLMpWl7wBb+xkXNEmlklma+zukXaz9hMakZHdh+r
        5udn757oHh/dYQbjFeP21LDxBC92VdEIiQ6vrsyoFkHYJbVvbxh+4jIqQHIhvTiVUvyGqMZ5gAh
        NkbfYet1/AE1vy3DrT0u7+Cj6gyJ6tvOoYuM11A==
X-Received: by 2002:a17:906:6a09:b0:926:ae94:adb4 with SMTP id qw9-20020a1709066a0900b00926ae94adb4mr13603302ejc.60.1678993047049;
        Thu, 16 Mar 2023 11:57:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set+S+c1YdU+vSGom8HcSFFE7KkoUgtGlA48PmMDgJ5JQIsdcyEjVJmMyaXnpX4FAZu28zSpTSQ==
X-Received: by 2002:a17:906:6a09:b0:926:ae94:adb4 with SMTP id qw9-20020a1709066a0900b00926ae94adb4mr13603283ejc.60.1678993046772;
        Thu, 16 Mar 2023 11:57:26 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906315600b0092421bf4927sm4159619eje.95.2023.03.16.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:57:26 -0700 (PDT)
Date:   Thu, 16 Mar 2023 19:57:23 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBNmk2hpao3D4E8m@righiandr-XPS-13-7390>
References: <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
 <ZBMQdgPepwa+VyAH@righiandr-XPS-13-7390>
 <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
 <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390>
 <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390>
 <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
 <ZBNXaF32nIh3Ca49@righiandr-XPS-13-7390>
 <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 16, 2023 at 07:55:36PM +0100, Ard Biesheuvel wrote:
...
> >
> > Yay! Success! I just tested your latest efi/urgent (with the fixup) and
> > system completed the boot without any soft lockups.
> >
> 
> Thanks for confirming. I'll take that as a tested-by

Sure, thanks!

Tested-by: Andrea Righi <andrea.righi@canonical.com>
