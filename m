Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C945B09D9
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIGQPO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIGQPN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:15:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B016B15A
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 09:15:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jm11so15024774plb.13
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=y1V8Rd0tasidsOrF+ijJfw9HYzfXkLgwZoX7BeU6Rrs=;
        b=fZQwLgPDoaUZJbcGTOjVCDAnjDbUfrKZD00iJpK+sP+qIlI8gZS/8hO4F3n1OSz7W/
         qtXyo3Oiy2rpaq/WZYrx5O8EBNCxVr3yWST3UE9SH1gZWICicJTwgGoY7B8DbB2OieWS
         aqyMD1/8dRY9GB8KpyhHU7S/bOT3mTiVT+rNgHg0+OloOFyCN69ppxXVCkgNJNiDrI5s
         18xaL6PwwBYdHtvMmSWKo7+mkJflxG2hQVMekI1bxw6r9rpibpNnzF/Mv5woQpyaGqd5
         xbxZJ42MU0P9sHqj/N5yLmoM/iNNa8RxVnxT1wFWQBrh+jMaGFFoJhXohDs4ZFOtkFYk
         fZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=y1V8Rd0tasidsOrF+ijJfw9HYzfXkLgwZoX7BeU6Rrs=;
        b=L8FbW/J73GiO+3fws0G88+x3B2e01fgQ3gypV0SJJAHfEt8kSNFUbrKmXIDKLzgyYH
         mEHyQe7/bvcTeV/ULijzMc9RvEbmBv6VIf2LhwtBI+FEHrdNH79R1P90tZpuC2bXFpG6
         zbA5bcv13qBDuVQ+3r9vC1DsafrEa8zNYwunWS2IXBY4eVaZXRlW5FpMqonlS5O4osIR
         DbWmRy3EpagL8WPolsL/jwyNR3OWenQY1Vyf+RRx+e+tPolAAPhzcMb+rGibJLx6XnU3
         JyMC9EQGfWrmS3N2hfgBWw09KX+WCehNiDclvVgvpJzGGIPUF75vYCwLj2kPF3dlLblb
         HWEw==
X-Gm-Message-State: ACgBeo0lQqKrzGUfQV8FrQhVozStbj/C6LsQ25NXBhofBMInbY2sTqn2
        ADrWGZWG3xGIusjdcM4JVb1zsISPTbA=
X-Google-Smtp-Source: AA6agR5+pCDZQtc0ksrJhvi00HIuZCzUKzFCcAZLqCljMj6sgmGSvyGbnLLRoCtZX7fhGJODVIr2sw==
X-Received: by 2002:a17:90b:180b:b0:1fd:d537:dd30 with SMTP id lw11-20020a17090b180b00b001fdd537dd30mr4898912pjb.75.1662567312677;
        Wed, 07 Sep 2022 09:15:12 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a910500b001f50c1f896esm11173369pjo.5.2022.09.07.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:15:12 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:15:08 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH v5] efi: capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907161508.GA150175@ubuntu>
References: <20220907160714.GA150039@ubuntu>
 <CAMj1kXES-fQ2jT6icvL0Jk7twV9gKYnwUpnNE956qcg96D4RUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXES-fQ2jT6icvL0Jk7twV9gKYnwUpnNE956qcg96D4RUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 07, 2022 at 06:12:57PM +0200, Ard Biesheuvel wrote:
> Thanks for the fix, I will queue it up before the end of the week.

Okay. Thanks for the patch feedback.

Regards,
Hyunwoo Kim.
