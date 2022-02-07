Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC44ACB8A
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiBGVpo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 16:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbiBGVpn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 16:45:43 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC91C06109E
        for <linux-efi@vger.kernel.org>; Mon,  7 Feb 2022 13:45:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g8so5453133pfq.9
        for <linux-efi@vger.kernel.org>; Mon, 07 Feb 2022 13:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C54NHAHJe2/RhvlXxtN7Quo9XCOtI81aWyvbTsjYtFo=;
        b=WYj4mFjAk6xht/r9QypenfKoozQsNt1hZb9UVLupmsvKeRxgH4hAvbq0X32fICFEQL
         NqqTzy0DS9MAn7DNgVlGKUun4x4nh44sEMZnGxmlL7I28wfcP8KbDOh2SlMDx6Qw6eq3
         yFWZvcvI0fMUrZ2pwsgr7NxV55WGpZtirafQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C54NHAHJe2/RhvlXxtN7Quo9XCOtI81aWyvbTsjYtFo=;
        b=MxRDdnIBvmmccZ4KlAqgqKCE77yeQBPfpvCWv0N5QibFSYgTFaV3h1kmjH02/3aHiv
         MTnfY3AUth89kVtMcLRD0sp7qRtsUJMJ3Z+TOqAE8VPdIJf5V0ZnK97FZRmwPyDYPqCX
         sBDEvfyxiuppwqr6tOd/07gnVW2vL5qTYw14eF5me76vnp2VD31/Z/BK354+9uGUNMDD
         7uG6ywQVcgoPHd4n6YmaorxgfmIVoiUdvwb+iTdYJDrVY8Ajd0b7EX5RFvGpx/vPCMqP
         DAjPZ5IFY/2HGNmXDwJRuT8r4cFd6n6bGnFSPSIE4g/5uh11NzEJmIJaqgWAXiPOk67o
         QlEw==
X-Gm-Message-State: AOAM530ofOrL6ARgHS1q2zkpS93MYMJ2D8lqNEKO3v6tTK7XABCvJNUR
        dYHDtQh+wbsCsR53SqTWIcdN5w==
X-Google-Smtp-Source: ABdhPJxNZEPOxw9TppzGQbOpuglsG0ky7x1oEV1Zp16yu8938Adf8G2a+ttz7MKgKhFpMpcMJqYinA==
X-Received: by 2002:a63:69c8:: with SMTP id e191mr1077596pgc.412.1644270341903;
        Mon, 07 Feb 2022 13:45:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm12919245pfl.71.2022.02.07.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:45:41 -0800 (PST)
Date:   Mon, 7 Feb 2022 13:45:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
Message-ID: <202202071325.F8450B3B2D@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-4-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203164328.203629-4-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 03, 2022 at 01:43:25PM -0300, Martin Fernandez wrote:
> __e820__range_update and e820__range_remove had a very similar
> implementation with a few lines different from each other, the lines
> that actually perform the modification over the e820_table. The
> similiraties were found in the checks for the different cases on how
> each entry intersects with the given range (if it does at all). These
> checks were very presice and error prone so it was not a good idea to
> have them in both places.

Yay removing copy/paste code! :)

> 
> I propose a refactor of those functions, given that I need to create a
> similar one for this patchset.

The diff here is pretty hard (for me) to review; I'll need more time
to check it. What might make review easier (at least for me), is to
incrementally change these routines. i.e. separate patches to:

- add the new infrastructure
- replace e820__range_remove
- replace __e820__range_update

If that's not actually useful, no worries. I'll just stare at it a bit
more. :)

> 
> Add a function to modify a E820 table in a given range. This
> modification is done backed up by two helper structs:
> e820_entry_updater and e820_*_data.
> 
> The first one, e820_entry_updater, carries 3 callbacks which function
> as the actions to take on the table.
> 
> The other one, e820_*_data carries information needed by the
> callbacks, for example in the case of range_update it will carry the
> type that we are targeting.

Something I think would be really amazing here is if you could add KUnit
tests here to exercise the corner cases and validate the changes. It
should be pretty easy to add. Here's a quick example for the boilerplate
and testing a bit of __e820__range_add():

#ifdef CONFIG_E820_KUNIT_TEST
#include <kunit/test.h>

static void __init test_e820_range_add(struct kunit *context)
{
	struct e820_table table;
	u32 full;

	full = ARRAY_SIZE(table.entries);
	/* Add last entry. */
	table->nr_entries = full - 1;
	__e820__range_add(&table, 0, 15, 0);
	KUNIT_EXPECT_EQ(table->nr_entries, full)
	/* Skip new entry when full. */
	__e820__range_add(&table, 0, 15, 0);
	KUNIT_EXPECT_EQ(table->nr_entries, full)
}

static void __init test_e820_update(struct kunit *context)
{
...
}

static struct kunit_case __refdata e820_test_cases[] = {
        KUNIT_CASE(test_e820_range_add),
        KUNIT_CASE(test_e820_update),
	...
        {}
};

static struct kunit_suite e820_test_suite = {
        .name = "e820",
        .test_cases = e820_test_cases,
};

kunit_test_suites(&e820_test_suite);
#endif

-- 
Kees Cook
