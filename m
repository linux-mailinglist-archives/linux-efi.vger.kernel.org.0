Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5316E58B0
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 07:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDRFm6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 01:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDRFm5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 01:42:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43AB423B
        for <linux-efi@vger.kernel.org>; Mon, 17 Apr 2023 22:42:55 -0700 (PDT)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C05FA3F230
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 05:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681796572;
        bh=yn8DJr6GcvbNzCSsJAayTneoxBSrRmv84MbMN1uOnBg=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=TrIy4Qa1EFFXjbztHaT1XoJthkUyUpHk8jeA+m7ql39IRCyTtXPtePdiZ4qLgZ5Xt
         cHZ5+vzHQxw3thtDPo4RXk8gOgw0iEZIKkckGxE1UidgLznw0dShiqdjPcCe1CgK8G
         lPSZuRMHMw0dp1RKjuNQRd188mVSVna7br2MhZU3DkZNhpwr4KuvaQdGWu2eggDdxR
         XTa7Ppmosk4klQgycm9uqDObnB+0L9rochD4pu677RuIkitmvxnQTXbs43TIzOOldw
         XlQYa3jtxXFYBIKuElO23romSF6/RKCXu9706Kz7/H+lDHBkeaBzt4DMLRHZhumsPr
         Azm+w7y4udOSw==
Received: by mail-ot1-f71.google.com with SMTP id l7-20020a9d5507000000b006a5ffbcef1eso4393oth.23
        for <linux-efi@vger.kernel.org>; Mon, 17 Apr 2023 22:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681796571; x=1684388571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn8DJr6GcvbNzCSsJAayTneoxBSrRmv84MbMN1uOnBg=;
        b=GRL3Hl0X9gTWZwvlpEDIpntfsIZPbiTPn6OdDuwNTKdzz/q099kpY3exNrhvr0in5G
         zPHqDMcBgZhTxKm/RRqo59Y4s0BQQyOxW0wrnyQQkPvR7vk90ufnDPe2bDPP/tgNZcQt
         CAOzGhHa0fUR0PMbtqqJT1t6rJ6M0tif+4gJC5hyYUnnmw8lbYDcVwd3CPT3g0d3mrm6
         1TfRYb3eJ+FKpR6u3gf3DHpzRiNRdrk97+YSOo/y77b1DMcy7q7wFOnvqD3C58uhdmIv
         G6+IryArxmc7KK6BFLChJInNKe1dhX6sbG5BleHbwN0osteymqDAGi+iwZXtRuJp9GR0
         jWcw==
X-Gm-Message-State: AAQBX9fH+4vyTcwSBWQjweiV4m51SLh5hnN4bcGRoonXReOmOIZ8Km11
        YlnBjSbpuEbXIfcYvaeRg9f46TDcP668gmlVElrbF15vqaz4U74B8lCUabf9mNCaUB/LXcMfr+Q
        uBHZXeAqQdOgML4n685T2QaU0ezigbcXloR9DlkOsdqSHNtvF
X-Received: by 2002:a4a:2c10:0:b0:545:dd1a:11f6 with SMTP id o16-20020a4a2c10000000b00545dd1a11f6mr2782267ooo.5.1681796571517;
        Mon, 17 Apr 2023 22:42:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZKCU+s4ajnIE5EKbBRPxf39+b6SCeH3j9epOASuTaRI62JzK2SzWUY2JbP2yzN2yO2K36Yhg==
X-Received: by 2002:a4a:2c10:0:b0:545:dd1a:11f6 with SMTP id o16-20020a4a2c10000000b00545dd1a11f6mr2782257ooo.5.1681796571252;
        Mon, 17 Apr 2023 22:42:51 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id f4-20020a4a5804000000b00541f66fdac8sm2695094oob.17.2023.04.17.22.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 22:42:50 -0700 (PDT)
Date:   Tue, 18 Apr 2023 07:42:47 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZD4t1++iAuOLly/R@righiandr-XPS-13-7390>
References: <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390>
 <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
 <ZBNXaF32nIh3Ca49@righiandr-XPS-13-7390>
 <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
 <ZBOYBdJR00dOKPSx@fedora>
 <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
 <ZDhlBjbRGufpDm6u@righiandr-XPS-13-7390>
 <ZD3CniUzNXVJRthE@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD3CniUzNXVJRthE@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 17, 2023 at 03:05:18PM -0700, Darren Hart wrote:
> On Thu, Apr 13, 2023 at 10:24:38PM +0200, Andrea Righi wrote:
> > 
> > Not sure if it's a similar issue, but I have found another Ampere box
> > that is booting fine with your fixes, but the eifvars.sh kselftest is
> > failing with some I/O errors, specifically:
> 
> Thanks for reporting. Can you confirm this worked reliably for you prior
> to v6.1?
> 
> --
> Darren

I tested again and I confirm that after a reboot everything looks fine.
Maybe EFI was messed up with a previous test and the latest kernel fixes
everything. Anyway this issue seems resolved for me.

Thanks,
-Andrea

> 
> > 
> > $ sudo ./efivarfs.sh
> > --------------------
> > running test_create
> > --------------------
> > ./efivarfs.sh: line 58: printf: write error: Input/output error
> > /sys/firmware/efi/efivars/test_create-210be57c-9849-4fc7-a635-e6382d1aec27 has invalid size
> >   [FAIL]
> > --------------------
> > running test_create_empty
> > --------------------
> >   [PASS]
> > --------------------
> > running test_create_read
> > --------------------
> >   [PASS]
> > --------------------
> > running test_delete
> > --------------------
> > ./efivarfs.sh: line 103: printf: write error: Input/output error
> >   [PASS]
> > --------------------
> > running test_zero_size_delete
> > --------------------
> > ./efivarfs.sh: line 126: printf: write error: Input/output error
> > ./efivarfs.sh: line 134: printf: write error: Input/output error
> > /sys/firmware/efi/efivars/test_zero_size_delete-210be57c-9849-4fc7-a635-e6382d1aec27 should have been deleted
> >   [FAIL]
> > --------------------
> > running test_open_unlink
> > --------------------
> > open(O_WRONLY): Operation not permitted
> >   [FAIL]
> > --------------------
> > running test_valid_filenames
> > --------------------
> > ./efivarfs.sh: line 158: printf: write error: Input/output error
> > ./efivarfs.sh: line 158: printf: write error: Input/output error
> > ./efivarfs.sh: line 158: printf: write error: Input/output error
> > ./efivarfs.sh: line 158: printf: write error: Input/output error
> >   [PASS]
> > --------------------
> > running test_invalid_filenames
> > --------------------
> >   [PASS]
> > 
> > If it helps:
> > 
> > $ sudo hexdump -C /sys/firmware/dmi/entries/4-0/raw
> > 00000000  04 30 04 00 01 03 fe 02  c1 d0 3f 41 00 00 00 00  |.0........?A....|
> > 00000010  03 8a 72 06 b8 0b f0 0a  41 06 05 00 06 00 07 00  |..r.....A.......|
> > 00000020  04 05 06 50 50 50 04 00  01 01 01 00 01 00 01 00  |...PPP..........|
> > 00000030  43 50 55 20 31 00 41 6d  70 65 72 65 28 52 29 00  |CPU 1.Ampere(R).|
> > 00000040  41 6d 70 65 72 65 28 52  29 20 41 6c 74 72 61 28  |Ampere(R) Altra(|
> > 00000050  52 29 20 50 72 6f 63 65  73 73 6f 72 00 30 30 30  |R) Processor.000|
> > 00000060  30 30 30 30 30 30 30 30  30 30 30 30 30 30 32 35  |0000000000000025|
> > 00000070  35 30 32 30 39 30 33 33  38 36 35 42 34 00 30 30  |50209033865B4.00|
> > 00000080  30 30 30 30 30 31 00 51  38 30 2d 33 30 00 00     |000001.Q80-30..|
> > 0000008f
> > 
> > I guess EFI is not very reliable here...
> > 
> > -Andrea
> 
> -- 
> Darren Hart
> Ampere Computing / OS and Kernel
