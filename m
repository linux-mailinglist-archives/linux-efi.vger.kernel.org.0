Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7456F4232
	for <lists+linux-efi@lfdr.de>; Tue,  2 May 2023 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjEBLCM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 May 2023 07:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjEBLCM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 May 2023 07:02:12 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E1469B;
        Tue,  2 May 2023 04:02:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-618a8632655so6987706d6.0;
        Tue, 02 May 2023 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683025328; x=1685617328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cKLyllcfQGZqzpBxsF4Eqgw2W0l3PU1/BE31uc1EHrI=;
        b=qrMX4W3z89HP9oASZqDVljhW2/V/AVDopVMvrfNVM9/KnBrHgfbkIu4ZEy0OgbrObE
         P6cOs9JdCynYWBWeePQi1fAiYpSiUwVIOaiizoEJKmdLNMjn7MsGeDeH83hjmu7aqu0A
         0aDq7+/xh0lNmu+ByckzHyG4qgpesaBjj3qH6heM7iPeFvh7vh2dxxoX4OLpw4cLySUm
         eC5iIFRphjU2XBjux8NVWW0v1317ZXv8Au/HdMPhyT3ChJa1kxwfRJAMvjHEww3JiVLa
         JQsk5g90q9ZrFQfbZRYW1U1rHYx37zVP/ekgswVlPHfyfXyjtpGn0H6r5r8atl+fA6FV
         VD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025328; x=1685617328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKLyllcfQGZqzpBxsF4Eqgw2W0l3PU1/BE31uc1EHrI=;
        b=fzwJdP+D2gmNNXQuNDeD3Wl+gZho4rwXQ5K4WwraXKBE8oeW2IxBkJWZfUfxwx6zGV
         1OMmUq7ftqFxbIzMaukvj9HUy8KW6F11WvlZYsqPWshLZd3ZiAbsAX8f8ArS6jokmD32
         YrEJsF3fIZSqr/hMIoIBzHGIBRnTXy6K0J8uU/PGYBOftVS7VzOe8V4gvhFNptYZe6C5
         6Ku7noImxGxCWpnuBzwRP7Ixl/Mm5cQE3FPE7nkf95q9xMmr9OxxRYeDjTnJdL5ktBpR
         DXpHsmJyriTBy6pUSObOkRHMI5HVn4KbHYbsUeboq//TWMSntv/oQllSChUM9r4tEE+I
         SFZQ==
X-Gm-Message-State: AC+VfDyCdbXLhxQ5/xxoT8pyDaBjRsihnkP8Jdug9oJpy3TH73DDNIQb
        ttAl+IwGQUNwtPIUGqBIi1CH2P1aYRdxJPShBe8=
X-Google-Smtp-Source: ACHHUZ7kyo7RMgy6ggiQBDmbJeZWGDjLIWOI34WKy3b3O8xtvEneGSJhKrn3bo9DDEKix9f2V3zPxiEpEG8XxLBYcqg=
X-Received: by 2002:a05:6214:528f:b0:616:73d9:b9c9 with SMTP id
 kj15-20020a056214528f00b0061673d9b9c9mr2907496qvb.0.1683025328586; Tue, 02
 May 2023 04:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230426195853.633233-1-anisse@astier.eu> <MN0PR12MB6101768A09C5C2C78C2B9B58E2659@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101768A09C5C2C78C2B9B58E2659@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Tue, 2 May 2023 12:01:57 +0100
Message-ID: <CAD2FfiELuWnOCMv8hwHOQase78PpRew7HHW3ATLHrxRxFOj2fw@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: expose used and total size
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Anisse Astier <anisse@astier.eu>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeremy Kerr <jk@ozlabs.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anisse Astier <an.astier@criteo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Apr 2023 at 22:50, Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
> This can be quite useful for fwupd to be capturing as well with some of the
> weird issues that look like they're probably related to how much variable
> space is left.

Yes, agreed, this will be very useful indeed. Thanks!

Richard
