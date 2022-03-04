Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2944CDF1D
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiCDUdl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 15:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiCDUdZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 15:33:25 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494CF1F5849
        for <linux-efi@vger.kernel.org>; Fri,  4 Mar 2022 12:32:23 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id f38so19170255ybi.3
        for <linux-efi@vger.kernel.org>; Fri, 04 Mar 2022 12:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Va0AzpfFrj2CIxQZYECbB+NvfeYwGm1BAKxA+n6QB4=;
        b=aqiySkX9xXwyx0pXK5VRBPZs+THKKNzuz8P4dXhtgCvyYD83k10XEbPITizjiFC5+1
         +uJJ/WstvMVQTxU+LxuP8XvWADlDCdusBlVQa6BMMZVrW+OvyLaQ8uvd5/vC5a3PIP7E
         7y8BB4T4piZJGQnj00J7i5/x2Tvr9Q2Vswp09xESARUUFkWHsHOeWImu8+bTyTXXx/eQ
         bg48wFjeuxt3dXnyUZI9XGuyC+9UU7Mxo4DmQDp55ReOUMP1xATcFBsHN4NlsMWvv7SO
         XFJtejMlR6DmbxBbJo6wJuIsEUUP9J9LGUSnI+XbbgA5eFTL5pRLbzkWbAK92pr+ZBX7
         OlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Va0AzpfFrj2CIxQZYECbB+NvfeYwGm1BAKxA+n6QB4=;
        b=HKt0Ycr7OWIZFmPrzy6v2ODei4oPe4WD/8xjRqWvZc8Y1Q8wZPafS2f40O8+uEyjt1
         Zh4FiOG5BrD3SfCxghM7Q0+lbqnnnwn+pqcgI/+lIoBbWshom0jVH8yOcoGXUN/1NGCD
         LsQt6ANKMYSFnUfvZe+KoozH/4dTeRC+7wbR8dGncBFSOVrHp2MDb5VvKHNQP/09KCHA
         YUwzmbHRENuFZiY5pd5AHlI1fmUakNffVYsDQdjx3q3PObbRo1bOIFE1tAcKGPeYgwkm
         OItreWeDLbbymSnIZaH8Zz4kbWHp6e2gl54lMZOtfD4IYbk/x6x82IRiiFP8M7Sop8Jh
         pRvA==
X-Gm-Message-State: AOAM532MTHEOfkJuXqM6U2rxeJJeX62hVGGvEuzbAqeSxr0yyHJOb+RW
        o/1iThu+ZuuOLVo1jwK97kE0GctcLKqXi9ttv5HOMQ==
X-Google-Smtp-Source: ABdhPJzxs23o8/HFTUjwCIU9Csa6E4rXqxc9gfNR5DpVCPks40rysm/OfOjtL91itmtSRi55jiNUior2jV/kxeE11DA=
X-Received: by 2002:a25:c487:0:b0:61d:9570:e77f with SMTP id
 u129-20020a25c487000000b0061d9570e77fmr202540ybf.229.1646425927962; Fri, 04
 Mar 2022 12:32:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0d:df06:0:0:0:0:0 with HTTP; Fri, 4 Mar 2022 12:32:07 -0800 (PST)
In-Reply-To: <202202071325.F8450B3B2D@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-4-martin.fernandez@eclypsium.com> <202202071325.F8450B3B2D@keescook>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Fri, 4 Mar 2022 17:32:07 -0300
Message-ID: <CAKgze5ZXzVYHK+iR0RMRy+M9ws6kFiq0XY55+fmxmo3baUu+Bw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/7/22, Kees Cook <keescook@chromium.org> wrote:
> Something I think would be really amazing here is if you could add KUnit
> tests here to exercise the corner cases and validate the changes. It
> should be pretty easy to add. Here's a quick example for the boilerplate
> and testing a bit of __e820__range_add():
>
> #ifdef CONFIG_E820_KUNIT_TEST
> #include <kunit/test.h>
>
> static void __init test_e820_range_add(struct kunit *context)
> {
> 	struct e820_table table;
> 	u32 full;
>
> 	full = ARRAY_SIZE(table.entries);
> 	/* Add last entry. */
> 	table->nr_entries = full - 1;
> 	__e820__range_add(&table, 0, 15, 0);
> 	KUNIT_EXPECT_EQ(table->nr_entries, full)
> 	/* Skip new entry when full. */
> 	__e820__range_add(&table, 0, 15, 0);
> 	KUNIT_EXPECT_EQ(table->nr_entries, full)
> }
>
> static void __init test_e820_update(struct kunit *context)
> {
> ...
> }
>
> static struct kunit_case __refdata e820_test_cases[] = {
>         KUNIT_CASE(test_e820_range_add),
>         KUNIT_CASE(test_e820_update),
> 	...
>         {}
> };
>
> static struct kunit_suite e820_test_suite = {
>         .name = "e820",
>         .test_cases = e820_test_cases,
> };
>
> kunit_test_suites(&e820_test_suite);
> #endif

I almost got it. Although when added the tests I have a warning
when compiling, because KUnit doens't want to deal with __init things:

    WARNING: modpost: vmlinux.o(.data+0x26800): Section mismatch in
reference from the variable __UNIQUE_ID_array286 to the variable
.init.data:e820_test_suite
    The variable __UNIQUE_ID_array286 references
    the variable __initdata e820_test_suite
    If the reference is valid then annotate the
    variable with __init* or __refdata (see linux/init.h) or name the variable:
    *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

I need to test __init functions. I couldn't find any other similar
cases in existant code. Is there a nice way to solve this?

I'm adding the file that contains the tests just in case..


#include <kunit/test.h>

#include <asm/e820/api.h>
#include <asm/setup.h>

#define KUNIT_EXPECT_E820_ENTRY_EQ(test, entry, _addr, _size, _type,           \
				   _crypto_capable)                            \
	do {                                                                   \
		KUNIT_EXPECT_EQ((test), (entry).addr, (_addr));                \
		KUNIT_EXPECT_EQ((test), (entry).size, (_size));                \
		KUNIT_EXPECT_EQ((test), (entry).type, (_type));                \
		KUNIT_EXPECT_EQ((test), (entry).crypto_capable,                \
				(_crypto_capable));                            \
	} while (0)

struct e820_table test_table __initdata;

static void __init test_e820_range_add(struct kunit *test)
{
        u32 full;

        full = ARRAY_SIZE(test_table.entries);
        /* Add last entry. */
        test_table.nr_entries = full - 1;
        __e820__range_add(&test_table, 0, 15, 0, 0);
        KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
        /* Skip new entry when full. */
        __e820__range_add(&test_table, 0, 15, 0, 0);
        KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
}

static void __init test_e820_range_update(struct kunit *test)
{
	u64 entry_size = 15;
	u64 updated_size = 0;
	/* Initialize table */
	test_table.nr_entries = 0;
	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
			  E820_NOT_CRYPTO_CAPABLE);
	__e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
			  E820_NOT_CRYPTO_CAPABLE);
	__e820__range_add(&test_table, entry_size * 2, entry_size,
			  E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);

	updated_size = __e820__range_update(&test_table, 0, entry_size * 2,
					    E820_TYPE_RAM, E820_TYPE_RESERVED);
	/* The first 2 regions were updated */
	KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
				   E820_TYPE_RESERVED, E820_NOT_CRYPTO_CAPABLE);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
				   entry_size, E820_TYPE_RESERVED,
				   E820_NOT_CRYPTO_CAPABLE);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
				   entry_size, E820_TYPE_ACPI,
				   E820_NOT_CRYPTO_CAPABLE);

	updated_size = __e820__range_update(&test_table, 0, entry_size * 3,
					    E820_TYPE_RESERVED, E820_TYPE_RAM);
	/* Only the first 2 regions were updated */
	KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
				   E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
				   entry_size, E820_TYPE_RAM,
				   E820_NOT_CRYPTO_CAPABLE);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
				   entry_size, E820_TYPE_ACPI,
				   E820_NOT_CRYPTO_CAPABLE);
}

static void __init test_e820_range_remove(struct kunit *test)
{
	u64 entry_size = 15;
	u64 removed_size = 0;

	struct e820_entry_updater updater = {
		.should_update = remover__should_update,
		.update = remover__update,
		.new = remover__new
	};

	struct e820_remover_data data = {
		.check_type = true,
		.old_type = E820_TYPE_RAM
	};

	/* Initialize table */
	test_table.nr_entries = 0;
	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
			  E820_NOT_CRYPTO_CAPABLE);
	__e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
			  E820_NOT_CRYPTO_CAPABLE);
	__e820__range_add(&test_table, entry_size * 2, entry_size,
			  E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);

	/*
	 * Need to use __e820__handle_range_update because
	 * e820__range_remove doesn't ask for the table
	 */
	removed_size = __e820__handle_range_update(&test_table,
						   0, entry_size * 2,
						   &updater, &data);
	/* The first two regions were removed */
	KUNIT_EXPECT_EQ(test, removed_size, entry_size * 2);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0, 0);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0, 0);

	removed_size = __e820__handle_range_update(&test_table,
						   0, entry_size * 3,
						   &updater, &data);
	/* Nothing was removed */
	KUNIT_EXPECT_EQ(test, removed_size, 0);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0, 0);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0, 0);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
				   entry_size, E820_TYPE_ACPI,
				   E820_NOT_CRYPTO_CAPABLE);
}

static void __init test_e820_range_crypto_update(struct kunit *test)
{
	u64 entry_size = 15;
	u64 updated_size = 0;
	/* Initialize table */
	test_table.nr_entries = 0;
	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
			  E820_CRYPTO_CAPABLE);
	__e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
			  E820_NOT_CRYPTO_CAPABLE);
	__e820__range_add(&test_table, entry_size * 2, entry_size,
			  E820_TYPE_RAM, E820_CRYPTO_CAPABLE);

	updated_size = __e820__range_update_crypto(&test_table, 0, entry_size * 3,
						   E820_CRYPTO_CAPABLE);
	/* Only the region in the middle was updated */
	KUNIT_EXPECT_EQ(test, updated_size, entry_size);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
				   E820_TYPE_RAM, E820_CRYPTO_CAPABLE);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
				   entry_size, E820_TYPE_RAM,
				   E820_CRYPTO_CAPABLE);
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
				   entry_size, E820_TYPE_RAM,
				   E820_CRYPTO_CAPABLE);
}

static void __init test_e820_handle_range_update_intersection(struct
kunit *test)
{
	struct e820_entry_updater updater = {
		.should_update = type_updater__should_update,
		.update = type_updater__update,
		.new = type_updater__new
	};

	struct e820_type_updater_data data = {
		.old_type = E820_TYPE_RAM,
		.new_type = E820_TYPE_RESERVED
	};

	u64 entry_size = 15;
	u64 updated_size = 0;
	/* Initialize table */
	test_table.nr_entries = 0;
	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
			  E820_NOT_CRYPTO_CAPABLE);

	updated_size = __e820__handle_range_update(&test_table,
						   0, entry_size - 2,
						   &updater, &data);

	KUNIT_EXPECT_EQ(test, updated_size, entry_size - 2);

	/* There is a new entry */
	KUNIT_EXPECT_EQ(test, test_table.nr_entries, 2);

	/* The original entry now is moved */
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], entry_size - 2,
				   2, E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);

	/* The new entry has the correct values */
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 13,
				   E820_TYPE_RESERVED, E820_NOT_CRYPTO_CAPABLE);
}

static void __init test_e820_handle_range_update_inside(struct kunit *test)
{
	struct e820_entry_updater updater = {
		.should_update = type_updater__should_update,
		.update = type_updater__update,
		.new = type_updater__new
	};

	struct e820_type_updater_data data = {
		.old_type = E820_TYPE_RAM,
		.new_type = E820_TYPE_RESERVED
	};

	u64 entry_size = 15;
	u64 updated_size = 0;
	/* Initialize table */
	test_table.nr_entries = 0;
	__e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
			  E820_NOT_CRYPTO_CAPABLE);

	updated_size = __e820__handle_range_update(&test_table,
						   5, entry_size - 10,
						   &updater, &data);

	KUNIT_EXPECT_EQ(test, updated_size, entry_size - 10);

	/* There are two new entrie */
	KUNIT_EXPECT_EQ(test, test_table.nr_entries, 3);

	/* The original entry now shrinked */
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 5,
				   E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);

	/* The new entries have the correct values */
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 5,
				   entry_size - 10, E820_TYPE_RESERVED,
				   E820_NOT_CRYPTO_CAPABLE);
	/* Left over of the original region */
	KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size - 5,
				   5, E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
}

static struct kunit_case e820_test_cases[] __initdata = {
        KUNIT_CASE(test_e820_range_add),
        KUNIT_CASE(test_e820_range_update),
        KUNIT_CASE(test_e820_range_remove),
        KUNIT_CASE(test_e820_range_crypto_update),
        KUNIT_CASE(test_e820_handle_range_update_intersection),
        KUNIT_CASE(test_e820_handle_range_update_inside),
        {}
};

static struct kunit_suite e820_test_suite __initdata = {
        .name = "e820",
        .test_cases = e820_test_cases,
};

kunit_test_suite(e820_test_suite);
